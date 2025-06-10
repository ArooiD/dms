import {RootStore} from "../rootStore.js";
import {StoreContext} from '../StoreContext/StoreContext'

export const StoreProvider = ({children}) => {
    return <StoreContext.Provider value={RootStore}>{children}</StoreContext.Provider>;
}