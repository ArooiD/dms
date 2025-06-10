import {theme} from "antd";


const THEME_DARK = {
    algorithm: theme.darkAlgorithm,
    cssVar: true,
    token: {
        colorTextBase: 'rgb(250,250,251)',
        bodyBg: 'rgb(10,22,34)',
        colorBgContainer: 'rgb(8,26,45)',
        colorPrimaryBg: 'rgb(8,26,45)',
    },
    components: {
        Sider: {

        },
        Header: {

        },
        Layout: {
            bodyBg: '#0a1622',
            colorBgBase: '#0a1622',
            colorBgElevated: '#081a2d',
            algorithm: true,
        },
        Content: {
            bodyBg: '#FFFFFF',
            colorBgBase: '#FFFFFF',
            colorBgElevated: '#FFFFFF',
        }
    }
}

export default THEME_DARK