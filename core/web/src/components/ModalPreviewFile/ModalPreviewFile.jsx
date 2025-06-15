import {useEffect, useState} from "react";
import {Flex, Modal} from "antd";
import {useStores} from "../../utils/hooks/useStores.js";
import {observer} from "mobx-react-lite";


const UniversalFileLoader = ({ url, token }) => {
    const [fileContent, setFileContent] = useState(null);
    const [isPDF, setIsPDF] = useState(false);
    const [isHTML, setIsHTML] = useState(false);
    const [error, setError] = useState(null);

    useEffect(() => {
        const fetchFile = async () => {
            try {
                const response = await fetch(url, {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    },
                });

                if (!response.ok) {
                    throw new Error('Не удалось загрузить файл');
                }

                const contentType = response.headers.get('Content-Type');

                if (contentType.includes('application/pdf')) {
                    const blob = await response.blob();
                    setFileContent(URL.createObjectURL(blob));
                    setIsPDF(true);
                } else if (contentType.includes('text/html')) {
                    const text = await response.text();
                    setFileContent(text);
                    setIsHTML(true);
                } else if (contentType.includes('text/plain')) {
                    const text = await response.text();
                    setFileContent(text);
                    setIsHTML(false);
                } else {
                    throw new Error('Неподдерживаемый формат файла');
                }

            } catch (error) {
                setError(error.message);
            }
        };

        fetchFile();
    }, [url, token]);

    return (
        <div>
            {error && <p style={{ color: 'red' }}>Ошибка: {error}</p>}
            {isPDF ? (
                fileContent && (
                    <Document file={fileContent}>
                        <Page pageNumber={1} />
                    </Document>
                )
            ) : isHTML ? (
                <div dangerouslySetInnerHTML={{ __html: fileContent }} />
            ) : (
                <pre>{fileContent}</pre>
            )}
        </div>
    );
};

const ModalPreviewFile = observer(({callback_open, callback_close, previewFileUrl}) => {
    const {
        userStore: {
            getToken
        }
    } = useStores()

    return (
        <Modal
            width={'80%'}
            title={'Предпросмотр файла'}
            centered
            open={callback_open}
            onCancel={callback_close}
            cancelText={'Закрыть'}
            cancelButtonProps={{

            }}
            okButtonProps={{
                style: {display: 'none'}
            }}
        >
            <Flex style={{border: '1px solid rgba(255,255,255,0.1)', padding: '24px', borderRadius: '8px', overflow: 'auto', maxHeight: '80vh'}}>
                {previewFileUrl && <UniversalFileLoader url={previewFileUrl ?? ''} token={getToken()} />}
            </Flex>
        </Modal>
    )
})

export default ModalPreviewFile