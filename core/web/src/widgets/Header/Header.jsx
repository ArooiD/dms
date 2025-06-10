
import h from './Header.module.scss'
import {Button, Flex, Input} from "antd";
import {useStores} from "../../utils/hooks/useStores.js";
import {MoonOutlined, QuestionOutlined, SunOutlined} from "@ant-design/icons";
import {observer} from "mobx-react-lite";

const Header = observer(() => {
    const {
        systemStore: {
            HEADER_TITLE,
            IS_THEME_DARK,
            toggleTheme
        }
    } = useStores()

    return (
        <header className={h.container}>
            <Flex>
                {HEADER_TITLE}
            </Flex>
            <Flex>
                <Input placeholder={'Поиск'} />
            </Flex>
            <Flex gap={'small'}>
                <Button
                    icon={<QuestionOutlined />}
                />
                <Button
                    onClick={() => {
                        toggleTheme()
                    }}
                    icon={IS_THEME_DARK ? <MoonOutlined /> : <SunOutlined />}
                />
            </Flex>
        </header>
    )
})

export default Header