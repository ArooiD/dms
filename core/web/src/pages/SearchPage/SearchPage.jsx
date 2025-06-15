import sp from './SearchPage.module.scss'
import {Flex, Select, Typography} from "antd";
import {useNavigate, useParams, useSearchParams} from "react-router-dom";
import {useEffect, useState} from "react";
import {useStores} from "../../utils/hooks/useStores.js";


const SearchItem = (item) => {
    const parseHTML = (html) => {
        const parts = html.split(/(<mark>.*?<\/mark>)/g);

        return parts.map((part, index) =>
            <Typography.Text
                key={index}
                mark={part.startsWith('<mark>')}
            >
                {
                    part.startsWith('<mark>')
                        ? part.replace(/<\/?mark>/g, '')
                        : part
                }
            </Typography.Text>);
    };


    return (
        <Flex gap={'small'} className={sp.si} vertical>
            <Flex className={sp.si_body}>
                <div>
                    {parseHTML(item.snippet)}
                </div>
            </Flex>
            <Flex className={sp.si_footer} justify={'space-between'}>
                <Flex gap={'small'} align={'center'}>
                    <Typography.Text>{item.score}</Typography.Text>
                </Flex>
                <Flex gap={'small'} align={'center'}>
                    <Typography.Text>{item.did}</Typography.Text>
                    <Typography.Text>{item.pid}</Typography.Text>
                </Flex>
            </Flex>
        </Flex>
    )
}

const SearchPage = () => {
    const {query_string} = useParams()
    const [searchParams, setSearchParams] = useSearchParams()
    const {
        userStore: {
            logout,
            getToken
        }
    } = useStores()

    const navigate = useNavigate()

    const [searchResult, setSearchResult] = useState([])

    useEffect(() => {
        if (!searchParams.get('count')) setSearchParams({count: '10'})
        if (query_string) {
            const externalHost = import.meta.env.VITE_DOMAIN || "";
            fetch(`${externalHost}/index/search?query=${query_string}&count=${searchParams.get('count') ?? '10'}`, {
                method: 'GET',
                headers: {
                    authorization: `Bearer ${getToken()}`
                },
            })
                .then(response => {
                    if (response.status === 401) {
                        logout()
                        navigate('/login')
                    } else if (response.ok) return response.json()
                })
                .then(response => {
                    setSearchResult(response)
                    console.log('search => ',response)
                })
                .catch(e => {
                    console.error(e)
                })
        }
    }, [query_string, searchParams])

    return (
        <Flex vertical gap={'small'} className={sp.container}>
            <Flex className={sp.header} gap={'small'} justify={'space-between'}>
                <Flex align={'center'}>
                    <Typography.Text>{searchResult.length} результатов на запрос <span style={{fontWeight: '500'}}>{query_string}</span></Typography.Text>
                </Flex>
                <Flex align={'center'} gap={'small'}>
                    <Typography.Text>Отобразить результатов: </Typography.Text>
                    <Select onChange={(value) => { setSearchParams({count: value})}} value={searchParams.get('count') ?? '10'} options={[
                        { value: '10' },
                        { value: '25' },
                        { value: '50' },
                        { value: '100' },
                    ]} style={{minWidth: '128px'}} />
                </Flex>
            </Flex>
            <Flex className={sp.body}>
                {searchResult.length > 0 ? (
                    <Flex gap={'middle'} vertical className={sp.result}>
                        {searchResult.map((item, index) => (
                            <SearchItem {...item} key={index} />
                        ))}
                    </Flex>
                ) : <Flex>
                    <Typography.Text style={{fontSize: '20px', fontWeight: '500'}}>По вашему запросу ничего нет!</Typography.Text>
                </Flex>}
            </Flex>
            <Flex className={sp.footer}>

            </Flex>
        </Flex>
    )
}

export default SearchPage