import {Flex, Layout} from "antd";
import {useLocation, useNavigate, useOutlet} from "react-router-dom";
import Header from "../Header/Header.jsx";
import Sidebar from "../Sidebar/Sidebar.jsx";
import gc from './GeneralComponent.module.scss'
import {observer} from "mobx-react-lite";
import {Content} from "antd/lib/layout/layout.js";
import {useEffect} from "react";
import {useStores} from "../../utils/hooks/useStores.js";

const GeneralComponent = observer(() => {
    const location = useLocation()
    const navigate = useNavigate()
    const outlet = useOutlet()

    const {
        userStore: {
            getExpirationTime,
            logout
        }
    } = useStores()

    useEffect(() => {
        if (getExpirationTime() < new Date().getTime()) {
            logout()
            navigate('/login')
        }
    }, [location]);

    if (getExpirationTime() < new Date().getTime()) return (<></>)

    return (
        <Layout className={gc.container}>
            <Sidebar />
            <Flex vertical className={gc.content}>
                <Header />
                <Content className={gc.body}>
                    {outlet}
                </Content>
            </Flex>
        </Layout>
    )
})

export default GeneralComponent