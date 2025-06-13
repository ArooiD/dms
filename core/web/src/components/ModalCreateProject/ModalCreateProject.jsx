import {Flex, Form, Input, Modal, Select} from "antd";
import {useForm} from "antd/lib/form/Form.js";
import {useEffect, useState} from "react";
import TextArea from "antd/lib/input/TextArea.js";
import {useStores} from "../../utils/hooks/useStores.js";
import {useNavigate} from "react-router-dom";
import {observer} from "mobx-react-lite";
import {toJS} from "mobx";


const ModalCreateProject = observer(({callback_open, callback_close}) => {
    const [form] = useForm()
    const navigate = useNavigate()
    const {
        userStore: {
            logout,
            getToken,
        },
        systemStore: {
            setProjectsList,
            BUCKETS_LIST
        }
    } = useStores()

    const [status, setStatus] = useState('default')
    useEffect(() => {
        if (status !== 'default') setTimeout(() => {
            setStatus('default')
        }, 2000)
    }, [status]);

    const performCreateProject = (values) => {
        setStatus('pending');
        console.log(values);
        const temp = toJS(BUCKETS_LIST);
        console.log('res => ', temp);
        const externalHost = import.meta.env.VITE_DOMAIN || "";
        fetch(`${externalHost}/api/project`, {
            method: 'POST',
            headers: {
                authorization: `Bearer ${getToken()}`,
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(values)
        })
            .then(res => {
                if (res.status === 401) {
                    logout()
                    navigate('/login')
                } else if (res.ok) return res.json()
            })
            .then(res => {
                console.log(res)

                callback_close()
                form.resetFields()
                form.setFieldsValue({
                    access: 'private'
                })
                const result = {
                    count: BUCKETS_LIST.count + 1,
                    resultSet: [
                        ...BUCKETS_LIST.resultSet,
                        res
                    ]
                }
                setProjectsList(result)
            })
            .catch(e => {
                console.error(e)
            })
    }

    useEffect(() => {
        form.setFieldsValue({
            access: 'private'
        })
    }, []);


    return (
        <Modal
            okButtonProps={{
                size: 'large',
                htmlType: 'submit',
                loading: status === 'pending'
            }}
            cancelButtonProps={{
                size: 'large'
            }}
            title={'Создать проект'}
            centered
            open={callback_open}
            onCancel={callback_close}
            modalRender={dom => (
                <Form
                    size={'large'}
                    form={form}
                    layout={'vertical'}
                    onFinish={(values) => performCreateProject(values)}
                >
                    {dom}
                </Form>
            )}
        >
            <Flex vertical style={{width: '100%', padding: '24px 0'}}>
                <Form.Item
                    style={{width: '100%'}}
                    label={'Идентификатор'}
                    name={'slug'}
                    rules={[{required: true}]}
                >
                    <Input/>
                </Form.Item>
                <Form.Item
                    style={{width: '100%'}}
                    label={'Наименование'}
                    name={'name'}
                    rules={[{required: true}]}
                >
                    <Input/>
                </Form.Item>
                <Form.Item
                    style={{width: '100%'}}
                    label={'Описание'}
                    name={'description'}
                    rules={[{required: false}]}
                >
                    <TextArea/>
                </Form.Item>
                <Form.Item
                    style={{width: '100%'}}
                    label={'Доступ'}
                    name={'access'}
                    rules={[{required: true}]}
                >
                    <Select options={[
                        {
                            label: 'Приватный',
                            value: 'private'
                        },
                        {
                            label: 'Доступный',
                            value: 'shared'
                        }
                    ]}/>
                </Form.Item>
            </Flex>
        </Modal>
    )
})

export default ModalCreateProject