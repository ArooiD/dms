import {Button, Flex, Form, Input, Layout, Typography} from "antd";
import {useForm} from "antd/lib/form/Form.js";
import lp from './LoginPage.module.scss'
import {Content} from "antd/lib/layout/layout.js";
import {useEffect, useState} from "react";
import {ImageLogo} from "../../components/Icons/Icons.jsx";
import {useStores} from "../../utils/hooks/useStores.js";
import {observer} from "mobx-react-lite";
import {useNavigate} from "react-router-dom";


const LoginPage = observer(() => {
    const [form] = useForm()
    const navigate = useNavigate();
    const [status, setStatus] = useState('default')

    const {
        userStore: {
            login
        }
    } = useStores()

    useEffect(() => {
        if (status !== 'default') setTimeout(() => {
            setStatus('default')
        }, 2000)
    }, [status]);

    const performLogin = (values) => {
        setStatus('pending')
        const externalHost = import.meta.env.VITE_DOMAIN || "";
        fetch(`${externalHost}/api/auth/login`, {
            method: 'POST',
            body: JSON.stringify(values),
            headers: {
                'Content-Type': 'application/json'
            }
        })
            .then(res => {
                if (res) return res.json()
            })
            .then(res => {
                setStatus('success')
                if (res.access_token) {
                    login(res.access_token)
                    setTimeout(() => {
                        navigate('/')
                    }, 1000)
                }
            })
            .catch(e => {
                setStatus('error')
                console.error(e)
            })
    }

    return (
        <Layout className={lp.container}>
            <Content className={lp.body}>
                <ImageLogo width={'220px'} height={'100%'} dark />
                <Form
                    variant={'outlined'}
                    size={'large'}
                    className={lp.Form}
                    layout={'vertical'}
                    form={form}
                    onFinish={(values) => {performLogin(values)}}
                >
                    <Form.Item
                        className={lp.FormItem}
                        label={'Имя пользователя'}
                        name={'username'}
                        rules={[{required: true}]}
                    >
                        <Input />
                    </Form.Item>
                    <Form.Item
                        className={lp.FormItem}
                        label={'Пароль'}
                        name={'password'}
                        rules={[{required: true}]}
                    >
                        <Input.Password />
                    </Form.Item>
                    <Button danger={status === 'error'} loading={status === 'pending'} htmlType={'submit'} type={'primary'} style={{width: '100%'}}>
                        {status === 'pending' && 'Вход'}
                        {status === 'default' && 'Войти'}
                        {status === 'error' && 'Ошибка'}
                        {status === 'success' && 'Успешно'}
                    </Button>
                </Form>
            </Content>
        </Layout>
    )
})

export default LoginPage