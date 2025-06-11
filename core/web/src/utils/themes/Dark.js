import {theme} from "antd";


const COLOR_PALETTE = [
    '#ebcdfd',
    '#a385b5',
    '#735585',
    '#5b3d6d',
    '#432555',
    '#200232',
    '#130025'
]

const THEME_DARK = {
    algorithm: theme.darkAlgorithm,
    cssVar: true,
    token: {

    },
    components: {
        Layout: {
            colorBgBase: COLOR_PALETTE[2],
            colorBgElevated: COLOR_PALETTE[2],
            siderBg: COLOR_PALETTE[2],
            headerBg: COLOR_PALETTE[3],
            bodyBg: COLOR_PALETTE[4],
            algorithm: true,
        },
        Button: {
            colorBgContainer: COLOR_PALETTE[3],
            defaultBorderColor: COLOR_PALETTE[4],
            defaultHoverBorderColor: COLOR_PALETTE[1],
            defaultHoverColor: COLOR_PALETTE[0],
            colorPrimary: COLOR_PALETTE[1],
            colorPrimaryActive: COLOR_PALETTE[6],
            colorPrimaryHover: COLOR_PALETTE[4],
            algorithm: true,
        },
        Input: {
            colorBgContainer: COLOR_PALETTE[3],
            hoverBorderColor: COLOR_PALETTE[1],
            algorithm: true,
        },
        Modal: {
            headerBg: COLOR_PALETTE[3],
            contentBg: COLOR_PALETTE[3],
            algorithm: true,
        }
    }
}

export default THEME_DARK