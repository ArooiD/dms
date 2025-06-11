import {Flex, Layout, Typography} from "antd";
import bc from './ProjectCard.module.scss'
import {useStores} from "../../utils/hooks/useStores.js";
import {observer} from "mobx-react-lite";
import {useNavigate} from "react-router-dom";


const ProjectCard = observer(({name, slug, created, count, access, modified}) => {
    const {
        systemStore: {
            IS_THEME_DARK
        }
    } = useStores()
    const navigate = useNavigate();

    return (
        <Layout onClick={() => {
            navigate(`/browser/${slug}`)
        }} className={bc.container} style={{backgroundColor: IS_THEME_DARK ? '#5b3d6d': "#bb9dcd"}}>
            <Flex justify={'space-between'}>
                <Typography.Text style={{fontWeight: '500'}}>{name ?? `Без имени`}</Typography.Text>
                <Typography.Text style={{fontWeight: '500'}}>{count}</Typography.Text>
            </Flex>
            <Flex justify={'space-between'}>
                <Typography.Text style={{fontWeight: '500'}}>{new Date(modified).toLocaleString()}</Typography.Text>
                <Typography.Text style={{fontWeight: '500'}}>{access}</Typography.Text>
            </Flex>
        </Layout>
    )
})

export default ProjectCard