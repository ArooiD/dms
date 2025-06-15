import {theme} from "antd";


const COLOR_PALETTE = [
    '#0f1b2d',
    '#1c2a3a',
    '#274146',
    '#FFFFFF',
    '#4b8378',
    '#6ca68c',
    '#8cbf9f'
]

const THEME_LIGHT = {
    algorithm: theme.defaultAlgorithm,
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

// #ffe5ff
// #ebcdfd
// #d3b5e5
// #bb9dcd
// #a385b5

export default THEME_LIGHT