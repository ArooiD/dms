import {App, Button, Descriptions, Drawer, Dropdown, Flex, Segmented, Select, Typography, Upload} from "antd";
import SpinBlock from "../SpinBlock/SpinBlock.jsx";
import {useEffect, useState} from "react";
import {useStores} from "../../utils/hooks/useStores.js";
import {observer} from "mobx-react-lite";
import {useNavigate} from "react-router-dom";
import Radio from "antd/lib/radio/radio.js";
import {message} from "antd/lib";


function formatBytes(bytes) {
    const sizes = ['Б', 'КБ', 'МБ', 'ГБ', 'ТБ'];
    if (bytes === 0) return '0 Б';
    const i = Math.floor(Math.log(bytes) / Math.log(1024));
    return parseFloat((bytes / Math.pow(1024, i)).toFixed(2)) + ' ' + sizes[i];
}

const DrawerDetailFile = observer(({setOpenModalPreviewFile, callback_open, callback_close, selectedFile, project_id, updateProject, setPreviewFileUrl }) => {
    const [detailFile, setDetailFile] = useState([]);
    const navigate = useNavigate();

    const {
        userStore: {
            getToken,
            logout
        }
    } = useStores()

    useEffect(() => {
        if (selectedFile) {
            const externalHost = import.meta.env.VITE_DOMAIN || "";
            fetch(`${externalHost}/api/projects/${project_id}/versions/${selectedFile.slug}`, {
                method: 'GET',
                headers: {
                    authorization: `Bearer ${getToken()}`
                }
            })
                .then(response => {
                    if (response.status === 401) {
                        logout()
                        navigate('/login')
                    } else if (response.ok) return response.json()
                })
                .then(response => {
                    setDetailFile(response)
                })
                .catch(e => {
                    console.error(e)
                })
        } else {
            setDetailFile([]);
        }
    }, [selectedFile]);

    useEffect(() => {
        if (detailFile) setSelectedVersion(detailFile.sort((a, b) => b.ver - a.ver)[0]?.ver)
    }, [detailFile])

    const [selectedVersion, setSelectedVersion] = useState(0);


    const [isPending, setIsPending] = useState(false)
    const [isPendingUpload, setIsPendingUpload] = useState(false)

    const {message} = App.useApp()

    const getFile = () => {
        const externalHost = import.meta.env.VITE_DOMAIN || "";

        setPreviewFileUrl(`${externalHost}/api/projects/${project_id}/preview/${selectedFile.slug}/${selectedFile.version}`)
        callback_close()
        setOpenModalPreviewFile(true)
        // fetch(`${externalHost}/api/projects/${project_id}/preview/${selectedFile.slug}`, {
        //     method: 'GET',
        //     headers: {
        //         authorization: `Bearer ${getToken()}`
        //     }
        // })
        //     .then(response => {
        //         if (response.status === 401) {
        //             logout()
        //             navigate('/login')
        //         } else if (response.ok) return response.json()
        //     })
        //     .then(response => {
        //         console.log('file => ', response)
        //         setPreviewFile(response)
        //     })
        //     .catch(e => {
        //         console.error(e)
        //     })
    }

    const downloadFile = async (slug, extension, version) => {
        message.open({
            key: 'downloading',
            type: 'loading',
            content: 'Загрузка файла',
        });
        try {
            const externalHost = import.meta.env.VITE_DOMAIN || "";
            const response = await fetch(`${externalHost}/api/projects/${project_id}/documents/${slug}${version ? `/${version}` : ''}`, {
                method: 'GET',
                headers: {
                    authorization: `Bearer ${getToken()}`
                }
            });

            if (!response.ok) {
                throw new Error('Сетевая ошибка!');
            }

            const blob = await response.blob();

            const url = window.URL.createObjectURL(blob);
            const link = document.createElement('a');
            link.href = url;
            link.setAttribute('download', `${slug}.${extension}`);

            document.body.appendChild(link);
            link.click();
            link.parentNode.removeChild(link);

            window.URL.revokeObjectURL(url);

            message.open({
                key: 'downloading',
                type: 'success',
                content: 'Успешное скачивание',
            });
        } catch (error) {
            message.open({
                key: 'downloading',
                type: 'error',
                content: 'Ошибка скачивания файла!',
            });
            console.error('Ошибка при скачивании файла:', error);
        }
    };

    const handleUpdateFile = async (file) => {
        setIsPendingUpload(true)
        message.open({
            key: 'updatable',
            type: 'loading',
            content: 'Загрузка новой версии файла',
        });
        const formData = new FormData();
        formData.append('file', file);

        const externalHost = import.meta.env.VITE_DOMAIN || "";
        try {
            const response = await fetch(`${externalHost}/api/projects/${project_id}/documents/${selectedFile.slug}`, {
                method: 'PUT',
                body: formData,
                headers: {
                    authorization: `Bearer ${getToken()}`
                }
            });

            if (response.ok) {
                message.open({
                    key: 'updatable',
                    type: 'success',
                    content: 'Файл успешно обновлен!',
                });
                callback_close()
                updateProject()
            } else {
                message.open({
                    key: 'updatable',
                    type: 'error',
                    content: 'Ошибка обновления файла!',
                });
            }
            setIsPendingUpload(false)
        } catch (error) {
            message.open({
                key: 'updatable',
                type: 'error',
                content: 'Ошибка обновления файла!',
            });
            setIsPendingUpload(false)
        }

        return false;
    };

    return (
        <Drawer
            width={700}
            closable={true}
            open={callback_open}
            onClose={callback_close}
            getContainer={false}
        >
            {detailFile ? (
                <Flex>
                    <Flex vertical gap={'small'} style={{width: '100%', height: '100%'}}>
                        <Flex align={'center'} justify={'space-between'} style={{width: '100%'}}>
                            <Flex gap={'middle'} align={'center'}>
                                <Typography.Text>Версия</Typography.Text>
                                {detailFile.length > 0 ? detailFile.length > 3 ? (
                                    <Select
                                        size={'large'}
                                        style={{width: '100%'}}
                                        onChange={(value) => {
                                            setSelectedVersion(value)
                                        }}
                                        value={selectedVersion}
                                        options={detailFile
                                            .sort((a, b) => a.ver - b.ver)
                                            .map((el) => (
                                                {
                                                    value: el?.ver,
                                                    label: el?.ver
                                                }
                                            ))}
                                    />) : (
                                    <Segmented
                                        size={'large'}
                                        onChange={(value) => {
                                            setSelectedVersion(value)
                                        }}
                                        value={selectedVersion}
                                        options={detailFile
                                            .sort((a, b) => a.ver - b.ver)
                                            .map((el => el?.ver))
                                        }
                                    />
                                ) : <Flex>
                                    <Typography.Text>Пусто</Typography.Text>
                                </Flex>}
                            </Flex>
                            <Flex gap={'small'}>
                                <Button size={'large'} onClick={() => getFile()}>Предпросмотр</Button>
                                <Dropdown menu={{items: [
                                        {
                                            key: '1',
                                            label: <Typography.Text>Скачать последнюю версию</Typography.Text>,
                                            onClick: () => {
                                                downloadFile(selectedFile.slug, selectedFile.ext, detailFile.sort((a,b) => b.ver-a.ver)[0].ver)
                                            }
                                        },
                                        detailFile?.sort((a,b) => b?.ver-a?.ver)[0]?.ver === selectedVersion ? {} : {
                                            key: '2',
                                            label: <Typography.Text>Скачать выбранную версию</Typography.Text>,
                                            onClick: () => {
                                                downloadFile(selectedFile.slug, selectedFile.ext, selectedVersion)
                                            }
                                        },,
                                    ]}}>
                                    <Button size={'large'} onClick={() => {}}>Скачать</Button>
                                </Dropdown>
                                <Upload disabled={isPending || isPendingUpload} beforeUpload={handleUpdateFile} showUploadList={false}>
                                    <Button loading={isPendingUpload} disabled={isPending || isPendingUpload} type={'primary'} size={'large'}>Обновить</Button>
                                </Upload>
                            </Flex>
                        </Flex>
                        <table>
                            <tbody>
                            <tr>
                                <td>
                                    <Typography.Text>
                                        Наименование файла
                                    </Typography.Text>
                                </td>
                                <td>
                                    <Typography.Text>
                                        {detailFile.find(f => f.ver === selectedVersion)?.filename ?? 'Неизвестно'}
                                    </Typography.Text>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <Typography.Text>
                                        Расширение
                                    </Typography.Text>
                                </td>
                                <td>
                                    <Typography.Text>
                                        {detailFile.find(f => f.ver === selectedVersion)?.ext ?? 'Неизвестно'}
                                    </Typography.Text>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <Typography.Text>
                                        Размер
                                    </Typography.Text>
                                </td>
                                <td>
                                    <Typography.Text>
                                        {formatBytes(detailFile.find(f => f.ver === selectedVersion)?.size) ?? 'Неизвестно'}
                                    </Typography.Text>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <Typography.Text>
                                        Создан
                                    </Typography.Text>
                                </td>
                                <td>
                                    <Typography.Text>
                                        {detailFile.find(f => f.ver === selectedVersion)?.created ?? 'Неизвестно'}
                                    </Typography.Text>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <Typography.Text>
                                        Хеш
                                    </Typography.Text>
                                </td>
                                <td>
                                    <Typography.Text>
                                        {detailFile.find(f => f.ver === selectedVersion)?.hash ?? 'Неизвестно'}
                                    </Typography.Text>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <Typography.Text>
                                        Идентификатор DID
                                    </Typography.Text>
                                </td>
                                <td>
                                    <Typography.Text>
                                        {detailFile.find(f => f.ver === selectedVersion)?.did ?? 'Неизвестно'}
                                    </Typography.Text>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <Typography.Text>
                                        Идентификатор PID
                                    </Typography.Text>
                                </td>
                                <td>
                                    <Typography.Text>
                                        {detailFile.find(f => f.ver === selectedVersion)?.pid ?? 'Неизвестно'}
                                    </Typography.Text>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <Typography.Text>
                                        Идентификатор UID
                                    </Typography.Text>
                                </td>
                                <td>
                                    <Typography.Text>
                                        {detailFile.find(f => f.ver === selectedVersion)?.uid ?? 'Неизвестно'}
                                    </Typography.Text>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </Flex>
                </Flex>
            ) : <SpinBlock/>}
        </Drawer>
    )
})

export default DrawerDetailFile