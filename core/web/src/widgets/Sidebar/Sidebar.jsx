import {Button, Divider, Flex, Input, Layout} from "antd";
import s from './Sidebar.module.scss'
import {useEffect, useState} from "react";
import logo from '../../assets/logo.svg'
import {FileProtectOutlined, FileTextOutlined, LogoutOutlined, PlusOutlined} from "@ant-design/icons";
import Sider from "antd/lib/layout/Sider.js";


const Sidebar = () => {
    const [buckets, setBuckets] = useState([]);

    useEffect(() => {
        setBuckets([
            {
                key: '1',
                label: 'base-documents'
            },
            {
                key: '2',
                label: 'contracts'
            },
            {
                key: '3',
                label: 'test'
            },
        ])
    }, []);

    return (
        <Sider className={s.container}>
            <Layout className={s.top}>
                <Flex className={s.logo} justify={'center'} align={'center'}>
                    <img src={logo} style={{height: '40px'}} />
                </Flex>
                <Divider size={'small'} />
                <Button icon={<PlusOutlined />}>
                    Создать bucket
                </Button>
                <Input placeholder={'Поиск buckets'} />
                <Divider size={'small'}>Buckets</Divider>
                <Flex vertical gap={'small'}>
                    {buckets?.map((bucket) => (
                        <Button key={bucket.key} onClick={() => {

                        }}>
                            {bucket.label}
                        </Button>
                    ))}
                </Flex>
            </Layout>
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
                    <Button icon={<LogoutOutlined />}>
                        Выйти
                    </Button>
                </Flex>
            </Flex>
        </Sider>
    )
}

export default Sidebar