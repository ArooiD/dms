import {Flex} from "antd";
import {useParams} from "react-router-dom";
import {observer} from "mobx-react-lite";


const BucketBrowserPage = observer(() => {
    const { bucket_id } = useParams()

    return (
        <Flex vertical>
            {bucket_id}
        </Flex>
    )
})

export default BucketBrowserPage