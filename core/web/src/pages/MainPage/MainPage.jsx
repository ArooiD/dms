import {Button, Flex, Layout, Segmented, Table, Typography} from "antd";
import {observer} from "mobx-react-lite";
import mp from './MainPage.module.scss'
import {AppstoreOutlined, BarChartOutlined, BarsOutlined, RedoOutlined} from "@ant-design/icons";
import {useStores} from "../../utils/hooks/useStores.js";
import ProjectCard from "../../components/ProjectCard/ProjectCard.jsx";
import {useEffect, useState} from "react";
import {useNavigate} from "react-router-dom";

const MainPage = observer(() => {
    const {
        systemStore: {
            BUCKETS_LIST,
            IS_GRID_VIEW,
            setGridView
        }
    } = useStores()

    const [viewType, setViewType] = useState('grid')

    // useEffect(() => {
    //     setViewType(IS_GRID_VIEW ? 'grid' : 'list')
    // }, [IS_GRID_VIEW])

    useEffect(() => {
        setGridView(viewType === 'grid')
    }, [viewType])

    const navigate = useNavigate()

    return (
        <Flex vertical gap={'small'} className={mp.container}>
            <Flex gap={'small'} justify={'space-between'} align={'center'} className={mp.header}>
                <Typography.Text style={{fontWeight: '500'}}>Всего проектов: {BUCKETS_LIST.count}</Typography.Text>
                <Flex gap={'small'}>
                    <Button size={'large'} shape={'default'} icon={<BarChartOutlined/>}/>
                    <Button size={'large'} shape={'default'} icon={<RedoOutlined/>}/>
                    <Segmented
                        value={viewType}
                        size={'large'}
                        options={[
                            {value: 'list', icon: <BarsOutlined/>},
                            {value: 'grid', icon: <AppstoreOutlined/>},
                        ]}
                        onChange={(value) => {
                            setViewType(value)
                        }}
                    />
                </Flex>
            </Flex>
            <Layout className={`${mp.body} ${viewType === 'list' ? mp.bodyList : ""}`}>
                {viewType === 'grid' ?
                    BUCKETS_LIST?.resultSet?.map((item) => (
                        <ProjectCard key={item.i} {...item} />
                    ))
                    :
                    <Table
                        columns={[
                            {
                                title: '',
                                dataIndex: 'ITER',
                                key: 'ITER',
                                render: (_,record, index) => {
                                    return index + 1
                                }
                            },
                            {
                                title: 'Наименование',
                                dataIndex: 'name',
                                key: 'name',
                                render: (name, record) => (
                                    <Button ghost style={{width: '100%'}} onClick={() => {
                                        navigate(`/browser/${record.slug}`)
                                    }}>{name}</Button>
                                )
                            },
                            {
                                title: 'uid',
                                dataIndex: 'uid',
                                key: 'uid'
                            },
                            {
                                title: 'pid',
                                dataIndex: 'pid',
                                key: 'pid'
                            },
                            {
                                title: 'Создан',
                                dataIndex: 'created',
                                key: 'created'
                            },
                            {
                                title: 'Изменен',
                                dataIndex: 'modified',
                                key: 'modified'
                            },
                        ]}
                        dataSource={BUCKETS_LIST?.resultSet}
                    />
                }
            </Layout>
            <Flex className={mp.footer}>

            </Flex>
        </Flex>
    )
})

export default MainPage