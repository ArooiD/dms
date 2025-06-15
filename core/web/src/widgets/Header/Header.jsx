
import h from './Header.module.scss'
import {Button, Flex, Input, Typography, Layout} from "antd";
import {useStores} from "../../utils/hooks/useStores.js";
import {MoonOutlined, QuestionOutlined, SunOutlined} from "@ant-design/icons";
import {observer} from "mobx-react-lite";
import ModalQuestion from "../../components/ModalQuestion/ModalQuestion.jsx";
import {useState} from "react";
import {useNavigate} from "react-router-dom";

const Header = observer(() => {
    const {
        systemStore: {
            HEADER_TITLE,
            IS_THEME_DARK,
            toggleTheme
        }
    } = useStores()

    const navigate = useNavigate()

    const [openModalQuestion, setOpenModalQuestion] = useState(false)
    const handleCloseModalQuestion = () => { setOpenModalQuestion(false) }

    return (
        <Layout.Header className={h.container}>
            <Flex>
                <Typography.Text style={{fontWeight: '500', fontSize: '20px'}}>{HEADER_TITLE}</Typography.Text>
            </Flex>
            <Flex style={{position: 'absolute', left: '50%', transform: 'translate(-50%,0)'}}>
                <Input.Search onSearch={(value) => {
                    navigate(`/search/${value}`)
                }} size={'large'} placeholder={'Поиск'} />
            </Flex>
            <Flex gap={'small'}>
                <Button
                    size={'large'}
                    icon={<QuestionOutlined />}
                    onClick={() => { setOpenModalQuestion(true) }}
                />
                <Button
                    size={'large'}
                    onClick={() => {
                        toggleTheme()
                    }}
                    icon={IS_THEME_DARK ? <MoonOutlined /> : <SunOutlined />}
                />
            </Flex>

            <ModalQuestion
                callback_open={openModalQuestion}
                callback_close={handleCloseModalQuestion}
            />
        </Layout.Header>
    )
})

export default Header