import {Button, Divider, Flex, Input, Layout, Spin, Typography} from "antd";
import s from './Sidebar.module.scss'
import {useEffect, useState} from "react";
import logo from '../../assets/logo.svg'
import {FileProtectOutlined, FileTextOutlined, LogoutOutlined, PlusOutlined} from "@ant-design/icons";
import {useLocation, useNavigate} from "react-router-dom";
import ModalCreateProject from "../../components/ModalCreateProject/ModalCreateProject.jsx";
import {observer} from "mobx-react-lite";
import {useStores} from "../../utils/hooks/useStores.js";
import {ImageLogo} from "../../components/Icons/Icons.jsx";
import SpinBlock from "../../components/SpinBlock/SpinBlock.jsx";


const Sidebar = observer(() => {
    const navigate = useNavigate();

    const {
        systemStore: {
            IS_THEME_DARK,
            setProjectsList,
            BUCKETS_LIST
        },
        userStore: {
            logout,
            getToken
        }
    } = useStores()

    const [isPending, setIsPending] = useState(false);

    const [openModalCreateProject, setOpenModalCreateProject] = useState(false)
    const handleCloseModalCreateProject = () => { setOpenModalCreateProject(false) }

    const location = useLocation()

    useEffect(() => {
        setIsPending(true)
        const externalHost = import.meta.env.VITE_DOMAIN || "";
        fetch(`${externalHost}/api/projects`, {
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

                setProjectsList(res)
                setIsPending(false)
            })
            .catch(e => {
                console.error(e)
            })
    }, []);

    const [selectedItemId, setSelectedItemId] = useState(false)

    useEffect(() => {
        const paths = location.pathname.split('/')

        if (paths.length === 3 && paths[1] === 'browser') {
            setSelectedItemId(paths[2])
        } else {
            setSelectedItemId('')
        }
    }, [location])

    const performLogout = () => {
        logout()
        navigate(`/login`)
    }

    return (
        <Layout.Sider collapsible={false} className={s.container}>
            <Flex className={s.body} vertical gap={'16px'} justify={'space-between'}>
                <Flex vertical gap={'middle'} className={s.top}>
                    <Flex style={{cursor: 'pointer'}} onClick={() => {
                        navigate('/')
                    }} className={s.logo} justify={'center'} align={'center'}>
                        <ImageLogo dark={IS_THEME_DARK} width={'100%'} height={'100%'} />
                    </Flex>
                    <Divider size={'small'} style={{marginTop: 'unset'}} />
                    <Button onClick={() => { setOpenModalCreateProject(true) }} icon={<PlusOutlined />}>
                        Создать project
                    </Button>
                    <Input placeholder={'Поиск projects'} />
                    <Divider size={'small'}>Projects</Divider>
                    <Flex vertical gap={'small'}>
                        {!isPending ? BUCKETS_LIST?.resultSet?.length > 0 ? BUCKETS_LIST?.resultSet?.map((project) => (
                            <Button className={s.projectButton} type={selectedItemId === project.name ? 'primary' : 'default'} key={project.key} onClick={() => {
                                navigate(`/browser/${project.slug}`)
                            }}>
                                {project.name ?? project.pid}
                            </Button>
                        )) : <Flex justify={'center'}>
                            <Typography.Text style={{fontSize: '16px', fontWeight: '400'}}>Пусто</Typography.Text>
                        </Flex> : <Flex>
                            <SpinBlock />
                        </Flex>}
                    </Flex>
                </Flex>
                <Divider size={'small'} />
                <Flex vertical gap={'middle'}>
                    <Flex vertical gap={'small'}>
                        <Button icon={<FileTextOutlined />}>
                            Документация
                        </Button>
                        <Button icon={<FileProtectOutlined />}>
                            Лицензия
                        </Button>
                    </Flex>
                    <Divider size={'small'} />
                    <Flex vertical gap={'small'}>
                        <Button onClick={() => performLogout()} icon={<LogoutOutlined />}>
                            Выйти
                        </Button>
                    </Flex>
                </Flex>
            </Flex>

            <ModalCreateProject
                callback_open={openModalCreateProject}
                callback_close={handleCloseModalCreateProject}
            />
        </Layout.Sider>
    )
})

export default Sidebar