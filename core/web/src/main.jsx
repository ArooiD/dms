import {StrictMode} from 'react'
import {createRoot} from 'react-dom/client'
import './index.css'
import App from './App.jsx'
import {App as AppAntd} from 'antd'
import {BrowserRouter} from "react-router-dom";
import {StoreProvider} from "./utils/store/StoreProvider/StoreProvider";

createRoot(document.getElementById('root')).render(
    <StrictMode>
        <AppAntd style={{width: '100%', height: '100%'}}>
            <StoreProvider>
                <BrowserRouter>
                    <App/>
                </BrowserRouter>
            </StoreProvider>
        </AppAntd>
    </StrictMode>,
)
