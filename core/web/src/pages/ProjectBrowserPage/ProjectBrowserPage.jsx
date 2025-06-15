import {
    Breadcrumb,
    Button,
    Checkbox,
    Descriptions,
    Flex,
    Input,
    Table,
    Typography,
    Upload,
    message,
    Modal,
    App
} from "antd";
import {useLocation, useNavigate, useParams} from "react-router-dom";
import {observer} from "mobx-react-lite";
import bbp from './ProjectBrowserPage.module.scss'
import {
    ArrowLeftOutlined,
    ArrowUpOutlined,
    CopyOutlined,
    FileOutlined,
    FolderAddOutlined,
    FolderOutlined, UploadOutlined
} from "@ant-design/icons";
import {useEffect, useState} from "react";
import {useStores} from "../../utils/hooks/useStores.js";
import DrawerDetailFile from "../../components/DrawerDetailFile/DrawerDetailFile.jsx";
import SpinBlock from "../../components/SpinBlock/SpinBlock.jsx";
import ModalPreviewFile from "../../components/ModalPreviewFile/ModalPreviewFile.jsx";



function transformFolders(fileList) {
    const result = [];

    function findOrCreateFolder(folders, folderName) {
        let folder = folders.find(item => item.slug === folderName && item.isFolder);
        if (!folder) {
            folder = {slug: folderName, isFolder: true, files: [], folders: []};
            folders.push(folder);
        }
        return folder;
    }

    fileList.forEach(file => {
        const pathParts = file.slug.split('/').filter(part => part).slice(1);
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
    const {project_id} = useParams()
    const navigate = useNavigate()
    const location = useLocation()
    // const [messageApi, contextHolder] = message.useMessage();

    const {message, modal} = App.useApp()

    const [projectInfo, setProjectInfo] = useState({})
    const [projectDocuments, setProjectDocuments] = useState([])

    const [tableDocuments, setTableDocuments] = useState([])
    const [globalDocuments, setGlobalDocuments] = useState([])

    const updateProject = () => {
        setIsPending(true)
        const externalHost = import.meta.env.VITE_DOMAIN || "";
        fetch(`${externalHost}/api/projects/${project_id}/info`, {
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
                console.log('info => ',res)
                setProjectInfo(res)

                fetch(`${externalHost}/api/projects/${project_id}/documents`, {
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
        systemStore: {},
        userStore: {
            logout,
            getToken
        }
    } = useStores()

    const [projectPath, setProjectPath] = useState([])
    const [depth, setDepth] = useState(0);
    const [isPending, setIsPending] = useState(false)

    const goUp = () => {
        if (depth === 0) {
            navigate('/browser')
        } else {
            console.log(globalDocuments)
            // setTableDocuments()
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
        console.log('table => ', tableDocuments)
    }, [tableDocuments])

    useEffect(() => {
        console.log('global => ', globalDocuments)
        setTableDocuments(globalDocuments)
        setProjectPath([{
            title: project_id
        }])
    }, [globalDocuments])

    const [selectedFile, setSelectedFile] = useState(null)
    useEffect(() => {
        if (selectedFile) {
            setOpenDrawerDetailFile(true)
        }
    }, [selectedFile])
    const [openDrawerDetailFile, setOpenDrawerDetailFile] = useState(false)
    const handleCloseDrawerDetailFile = () => {
        setOpenDrawerDetailFile(false)
        setSelectedFile(null)
    }

    const [isPendingUpload, setIsPendingUpload] = useState(false)
    const handleUpload = async (file) => {
        setIsPendingUpload(true)
        message.open({
            key: 'updatable',
            type: 'loading',
            content: 'Загрузка файла',
        });
        const formData = new FormData();
        formData.append('file', file);

        const externalHost = import.meta.env.VITE_DOMAIN || "";
        try {
            const response = await fetch(`${externalHost}/api/projects/${project_id}/documents/new`, {
                method: 'POST',
                body: formData,
                headers: {
                    authorization: `Bearer ${getToken()}`
                }
            });

            if (response.ok) {
                message.open({
                    key: 'updatable',
                    type: 'success',
                    content: 'Файл успешно загружен!',
                });
                updateProject()
            } else {
                message.open({
                    key: 'updatable',
                    type: 'error',
                    content: 'Ошибка загрузки файла!',
                });
            }
            setIsPendingUpload(false)
        } catch (error) {;
            message.open({
                key: 'updatable',
                type: 'error',
                content: 'Ошибка загрузки файла!',
            });
            setIsPendingUpload(false)
        }

        return false;
    };

    const [previewFile, setPreviewFile] = useState(null)
    const [previewFileUrl,setPreviewFileUrl] = useState('')

    useEffect(() => {
        if (previewFileUrl && !openDrawerDetailFile) {
            setOpenModalPreviewFile(true)

            // fetch(previewFileUrl, {
            //     method: 'GET',
            //     headers: {
            //         authorization: `Bearer ${getToken()}`
            //     }
            // })
            //     .then(response => {
            //         if (response.status === 401) {
            //             logout()
            //             navigate('/login')
            //         } else if (response.ok) return response.json()
            //     })
            //     .then(response => {
            //         console.log('file => ', response)
            //         setPreviewFile(response)
            //     })
            //     .catch(e => {
            //         console.error(e)
            //     })
        }
    }, [previewFileUrl, openDrawerDetailFile]);

    const deleteProject = (p_id) => {
        const externalHost = import.meta.env.VITE_DOMAIN || "";
        fetch(`${externalHost}/api/projects/${p_id}`, {
            method: 'DELETE',
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
            })
            .catch(e => {
                console.error(e)
            })
    }

    const [openModalPreviewFile, setOpenModalPreviewFile] = useState(false)
    const handleCloseModalPreviewFile = () => { setOpenModalPreviewFile(false) }


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
                                children: <Typography.Text style={{whiteSpace: 'nowrap'}}>PRIVATE</Typography.Text>
                            },
                            {
                                label: 'Создан',
                                children: <Typography.Text>undefined</Typography.Text>
                            }
                        ]}
                    />
                </Flex>
                <Flex gap={'small'}>
                    <Button disabled={isPending || isPendingUpload} size={'large'} danger onClick={() => {
                        modal.confirm({
                            title: 'Удаление проекта',
                            description: 'Вы уверены, что хотите удалить проект? Все файлы будут уничтожены!',
                            onOk: () => deleteProject(project_id),
                        })
                    }}>Удалить</Button>
                    <Button disabled size={'large'}>Откатить</Button>
                    <Button disabled={isPending || isPendingUpload} size={'large'} onClick={() => {updateProject()}}>Обновить</Button>
                    <Upload disabled={isPending || isPendingUpload} beforeUpload={handleUpload} showUploadList={false}>
                        <Button loading={isPendingUpload} disabled={isPending || isPendingUpload} type={'primary'} size={'large'}>Загрузить</Button>
                    </Upload>
                </Flex>
            </Flex>
            <Flex vertical className={bbp.body} gap={'middle'}>
                <Flex gap={'small'} className={bbp.body_contentHeader}>
                    <Button onClick={() => navigate('/browser')} size={'large'} className={bbp.contentHeader__backButton}
                            icon={<ArrowLeftOutlined/>}/>
                    <Flex className={bbp.containerHeader_pathBlock}>
                        <Breadcrumb
                            items={projectPath.map((item) => ({
                                title: <Typography.Text className={bbp.breadcrumb_item} onClick={() => {
                                    console.log(item.title)
                                }}>{item.title}</Typography.Text>,
                            }))}
                        />
                        <Button icon={<CopyOutlined/>} className={bbp.pathBlock__copyPathButton}/>
                    </Flex>
                    <Button style={{aspectRatio: 1}} icon={<ArrowUpOutlined />} size={'large'} onClick={() => goUp()}></Button>
                    <Button style={{aspectRatio: 1}} icon={<FolderAddOutlined />} size={'large'}></Button>
                </Flex>
                <Flex style={{position: 'relative', height: '100%', overflow: 'clip', borderRadius: '8px'}}>
                    {(isPendingUpload || isPending) && <Flex style={{position: 'absolute', width: '100%', height: '100%'}}><SpinBlock /></Flex>}
                    <Table
                        onRow={(record, rowIndex) => {
                            return {
                                onClick: event => {
                                    if (record.isFolder) {
                                        setProjectPath([...projectPath, {
                                            title: record.slug
                                        }])
                                        console.log('папка')
                                        setDepth(prevState => prevState + 1);
                                        setTableDocuments([...record.folders, ...record.files])
                                    } else {
                                        console.log('файл', record)
                                        setSelectedFile(record)
                                    }
                                },
                            };
                        }}
                        style={{width: '100%'}}
                        columns={[
                            {
                                key: 'checkbox',
                                dataIndex: 'checkbox',
                                title: <Checkbox/>,
                                render: (_, record) => (
                                    <Checkbox/>
                                )
                            },
                            {
                                key: 'slug',
                                dataIndex: 'slug',
                                title: 'Наименование',
                                render: (name, record) => (
                                    <Flex gap={'small'}>
                                        {record.isFolder ? <FolderOutlined/> : <FileOutlined/>}
                                        <Typography.Text>{record.isFolder ? `${name}` : `${record.filename}.${record.ext}`}</Typography.Text>
                                    </Flex>
                                )
                            },
                            {
                                key: 'modified',
                                dataIndex: 'modified',
                                title: 'Изменен'
                            },
                            {
                                key: 'ver',
                                dataIndex: 'ver',
                                title: 'Версия'
                            }
                        ]}
                        dataSource={tableDocuments.sort(s => s.isFolder ? -1 : 1)}
                    />

                    <ModalPreviewFile
                        callback_open={openModalPreviewFile}
                        callback_close={handleCloseModalPreviewFile}
                        previewFileUrl={previewFileUrl}
                    />

                    <DrawerDetailFile setPreviewFileUrl={setPreviewFileUrl} updateProject={updateProject} callback_open={openDrawerDetailFile} callback_close={handleCloseDrawerDetailFile} selectedFile={selectedFile} project_id={project_id} />
                </Flex>
            </Flex>
            {/*<Flex className={bbp.footer}>*/}

            {/*</Flex>*/}
        </Flex>
    )
})

export default ProjectBrowserPage