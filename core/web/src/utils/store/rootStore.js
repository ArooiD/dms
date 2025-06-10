import {SystemStore} from "./stores/systemStore.js";
import {UserStore} from "./stores/userStore.js";


const systemStore = new SystemStore();
const userStore = new UserStore()


export const RootStore = {
    systemStore,
    userStore
}