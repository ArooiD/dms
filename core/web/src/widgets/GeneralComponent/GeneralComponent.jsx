import {Flex, Layout} from "antd";
import {useOutlet} from "react-router-dom";
import Header from "../Header/Header.jsx";
import Sidebar from "../Sidebar/Sidebar.jsx";
import gc from './GeneralComponent.module.scss'
import {observer} from "mobx-react-lite";
import {Content} from "antd/lib/layout/layout.js";

const GeneralComponent = observer(() => {
    const outlet = useOutlet()

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