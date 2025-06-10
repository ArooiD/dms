import React, {useEffect} from 'react'
import './App.css'
import {Navigate, Route, Routes, useLocation} from "react-router-dom";
import LoginPage from "./pages/LoginPage/LoginPage.jsx";
import GeneralComponent from "./widgets/GeneralComponent/GeneralComponent.jsx";
import MainPage from "./pages/MainPage/MainPage.jsx";
import BucketBrowserPage from "./pages/BucketBrowserPage/BucketBrowserPage.jsx";
import {ConfigProvider} from "antd";
import ruRU from 'antd/locale/ru_RU'
import {useStores} from "./utils/hooks/useStores.js";

import THEME_DARK from './utils/themes/Dark'
import THEME_LIGHT from './utils/themes/Light'
import {observer} from "mobx-react-lite";

const App = observer(() => {
    const isAuthorized = true
    const location = useLocation();
    const {
        systemStore: {
            IS_THEME_DARK,
            setHeaderTitle
        }
    } = useStores()

    useEffect(() => {
        const pathParts = location.pathname.split('/');
        if (pathParts[1] === 'browser' && pathParts.length === 3) {
            setHeaderTitle('Bucket браузер');
        } else {
            setHeaderTitle('Файловый браузер');
        }
    }, [location, setHeaderTitle])

    return (
        <ConfigProvider
            locale={ruRU}
            theme={IS_THEME_DARK ? THEME_DARK : THEME_LIGHT}
            wave={{
                disabled: true
            }}
        >
            <Routes>
                {isAuthorized && (
                    <Route path={'/'} element={<GeneralComponent />}>
                        <Route index element={<MainPage />} />
                        <Route path={'/browser'} component={<MainPage />} />
                        <Route path={'/browser/:bucket_id'} component={<BucketBrowserPage />} />
                        <Route path={'*'} element={<Navigate replace to={'/'} />} />
                    </Route>
                )}
                {!isAuthorized && <Route path={"*"} element={<LoginPage />}/>}
            </Routes>
        </ConfigProvider>
    )
})

export default App
