import {Flex, Modal} from "antd";


const ModalQuestion = ({callback_open, callback_close}) => {


    return (
        <Modal
            title={'Помощь'}
            centered
            open={callback_open}
            onCancel={callback_close}
        >
            <Flex>
                фывфывфы
            </Flex>
        </Modal>
    )
}

export default ModalQuestion