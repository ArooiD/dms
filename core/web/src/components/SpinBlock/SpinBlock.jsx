import {Flex, Spin} from "antd";
import sb from './SpinBlock.module.scss'
import {observer} from "mobx-react-lite";
import {useStores} from "../../utils/hooks/useStores.js";

const SpinBlock = observer(() => {
    const {
        systemStore: {
            IS_THEME_DARK
        }
    } = useStores()

    return (
        <Flex className={`${sb.container} ${IS_THEME_DARK ? sb.dark : ""}`}>
            <Spin />
        </Flex>
    )
})

export default SpinBlock