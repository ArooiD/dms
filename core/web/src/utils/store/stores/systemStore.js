import {makeAutoObservable} from "mobx";


export class SystemStore {
    IS_THEME_DARK = localStorage.getItem("d__theme") === 'dark';
    IS_GRID_VIEW = true
    HEADER_TITLE = ''
    BUCKETS_LIST = {count: 0, resultSet: []}

    constructor() {
        makeAutoObservable(this)

        if (!localStorage.getItem("d__theme")) {
            this.IS_THEME_DARK = false;
            localStorage.setItem("d__theme", "dark");
        }
    }

    toggleTheme = () => {
        this.IS_THEME_DARK = !this.IS_THEME_DARK;
        localStorage.setItem('d__theme', this.IS_THEME_DARK ? 'dark' : 'light');
    }
    toggleIsGridView = () => {
        this.IS_GRID_VIEW = !this.IS_GRID_VIEW;
    }
    setGridView = (value) => {
        this.IS_GRID_VIEW = value
    }
    setHeaderTitle = (value = '') => {
        this.HEADER_TITLE = value;
    }
    setProjectsList = (value = {count: 0, resultSet: []}) => {
        this.BUCKETS_LIST = value;
    }
}