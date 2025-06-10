import {theme} from "antd";


const THEME_LIGHT = {
    algorithm: theme.defaultAlgorithm,
    cssVar: true,
    token: {
        colorTextBase: 'rgb(11,11,12)',
        bodyBg: 'rgb(245,245,245)',
        colorBgContainer: 'rgb(255,255,255)',
        colorPrimaryBg: 'rgb(224,229,240)',
    },
    components: {
        Sider: {

        },
        Header: {

        },
        Layout: {
            bodyBg: '#F0F4F7',
            colorBgContainer: '#ffffff',
            colorBgElevated: '#f5f5f5',
            algorithm: true,
        },
        Content: {
            bodyBg: '#FFFFFF',
        },
    }
}

export default THEME_LIGHT