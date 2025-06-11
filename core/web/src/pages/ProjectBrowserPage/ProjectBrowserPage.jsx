import {Breadcrumb, Button, Checkbox, Descriptions, Flex, Input, Table, Typography} from "antd";
import {useLocation, useNavigate, useParams} from "react-router-dom";
import {observer} from "mobx-react-lite";
import bbp from './ProjectBrowserPage.module.scss'
import {ArrowLeftOutlined, CopyOutlined, FileOutlined, FolderOutlined} from "@ant-design/icons";
import {useEffect, useState} from "react";
import {useStores} from "../../utils/hooks/useStores.js";


function transformFolders(fileList) {
    const result = [];

    function findOrCreateFolder(folders, folderName) {
        let folder = folders.find(item => item.slug === folderName && item.isFolder);
        if (!folder) {
            folder = { slug: folderName, isFolder: true, files: [], folders: [] };
            folders.push(folder);
        }
        return folder;
    }

    fileList.forEach(file => {
        const pathParts = file.filename.split('/').filter(part => part).slice(1);
        if (pathParts.length === 1) {
            result.push(file);
        } else {
            let currentFolder = findOrCreateFolder(result, pathParts[0]);
            for (let i = 1; i < pathParts.length - 1; i++) {
                currentFolder = findOrCreateFolder(currentFolder.folders, pathParts[i]);
            }
            currentFolder.files.push(file);
        }
    });

    return result;
}

const ProjectBrowserPage = observer(() => {
    const { project_id } = useParams()
    const navigate = useNavigate()
    const location = useLocation()

    const [projectInfo, setProjectInfo] = useState({})
    const [projectDocuments, setProjectDocuments] = useState([])

    const [tableDocuments, setTableDocuments] = useState([])
    const [globalDocuments, setGlobalDocuments] = useState([])

    const updateProject = () => {
        setIsPending(true)


        fetch(`${import.meta.env.VITE_DOMAIN}/api/project/${project_id}/info`, {
            method: 'GET',
            headers: {
                authorization: `Bearer ${getToken()}`
            }
        })
            .then(res => {
                if (res.status === 401) {
                    logout()
                    navigate('/login')
                } else if (res.ok) return res.json()
            })
            .then(res => {
                console.log(res)
                setProjectInfo(res)

                fetch(`${import.meta.env.VITE_DOMAIN}/api/project/${project_id}/documents`, {
                    method: 'GET',
                    headers: {
                        authorization: `Bearer ${getToken()}`
                    }
                })
                    .then(response => {
                        if (response.status === 401) {
                            logout()
                            navigate('/login')
                        } else if (response.ok) return response.json()
                    })
                    .then(response => {
                        console.log(response)
                        setProjectDocuments(response)
                        setIsPending(false)
                    })
                    .catch(e => {
                        console.error(e)
                    })
            })
            .catch(e => {
                console.error(e)
            })
    }

    useEffect(() => {
        updateProject()
    }, [location])

    const {
        systemStore: {

        },
        userStore: {
            logout,
            getToken
        }
    } = useStores()

    const [projectPath, setProjectPath] = useState([])
    const [isPending, setIsPending] = useState(false)

    const goUp = () => {
        if (projectPath.length === 1) {
            navigate('/browser')
        }
    }


    useEffect(() => {
        //{
        //     "pid": "84055427-00ea-41e0-800a-e3e31f8acefc",
        //     "uid": "4e205f98-16db-4a8b-b873-06b4acd50ff4",
        //     "did": "a0f6f529-e49b-4fe4-a649-46691b3e168d",
        //     "slug": "a",
        //     "filename": "/my-project-slug/a.docx",
        //     "ext": "docx"
        // }
        setGlobalDocuments(transformFolders(projectDocuments))
    }, [projectDocuments])

    useEffect(() => {
        console.log('table => ',tableDocuments)
    }, [tableDocuments])

    useEffect(() => {
        console.log('global => ', globalDocuments)
        setTableDocuments(globalDocuments)
        setProjectPath([{
            title: project_id
        }])
    }, [globalDocuments])

    return (
        <Flex gap={'small'} vertical className={bbp.container}>
            <Flex align={'center'} justify={'space-between'} className={bbp.header}>
                <Flex vertical>
                    <Typography.Text style={{fontWeight: '500', fontSize: '18px'}}>{project_id}</Typography.Text>
                    <Descriptions
                        bordered={false}
                        items={[
                            {
                                label: 'Доступ',
                                children: <Typography.Text>PRIVATE</Typography.Text>
                            },
                            {
                                label: 'Создан',
                                children: <Typography.Text>segodna</Typography.Text>
                            }
                        ]}
                    />
                </Flex>
                <Flex gap={'small'}>
                    <Button size={'large'} danger onClick={() => {

                    }}>Удалить</Button>
                    <Button disabled size={'large'}>Откатить</Button>
                    <Button size={'large'}>Обновить</Button>
                    <Button type={'primary'} size={'large'}>Загрузить</Button>
                </Flex>
            </Flex>
            <Flex vertical className={bbp.body} gap={'small'}>
                <Flex gap={'small'} className={bbp.body_contentHeader}>
                    <Button onClick={() => goUp()} size={'large'} className={bbp.contentHeader__backButton} icon={<ArrowLeftOutlined />} />
                    <Flex className={bbp.containerHeader_pathBlock}>
                        <Breadcrumb
                            items={projectPath.map((item) => ({
                                title: <Typography.Text className={bbp.breadcrumb_item} onClick={() => {
                                    console.log(item.title)
                                }}>{item.title}</Typography.Text>,
                            }))}
                        />
                        <Button icon={<CopyOutlined />} className={bbp.pathBlock__copyPathButton} />
                    </Flex>
                    <Button size={'large'}>Создать директорию</Button>
                </Flex>
                <Flex>
                    <Table
                        onRow={(record, rowIndex) => {
                            return {
                                onClick: event => {
                                    if (record.isFolder) {
                                        setProjectPath([...projectPath, {
                                            title: record.slug
                                        }])
                                        console.log('папка')
                                        setTableDocuments([...record.folders, ...record.files])
                                    } else {
                                        console.log('файл')
                                    }
                                },
                            };
                        }}
                        style={{width: '100%'}}
                        columns={[
                            {
                                key: 'checkbox',
                                dataIndex: 'checkbox',
                                title: <Checkbox />,
                                render: (_,record) => (
                                    <Checkbox />
                                )
                            },
                            {
                                key: 'slug',
                                dataIndex: 'slug',
                                title: 'Наименование',
                                render: (name, record) => (
                                    <Flex gap={'small'}>
                                        {record.isFolder ? <FolderOutlined /> : <FileOutlined />}
                                        <Typography.Text>{name}{record.isFolder ? '' : `.${record.ext}`}</Typography.Text>
                                    </Flex>
                                )
                            },
                            {
                                key: 'modified',
                                dataIndex: 'modified',
                                title: 'Изменен'
                            },
                            {
                                key: 'size',
                                dataIndex: 'size',
                                title: 'Размер'
                            }
                        ]}
                        dataSource={tableDocuments.sort(s => s.isFolder ? -1 : 1)}
                    />
                </Flex>
            </Flex>
            <Flex className={bbp.footer}>

            </Flex>
        </Flex>
    )
})

export default ProjectBrowserPage