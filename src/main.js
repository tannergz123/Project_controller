import { createApp } from "vue";
import App from "./App.vue";
import store from "./store";
import router from "./router";
import "./assets/css/nucleo-icons.css";
import "./assets/css/nucleo-svg.css";
import ArgonDashboard from "./argon-dashboard";
import PrimeVue from 'primevue/config';
import axios from "axios";
import DataTable from 'primevue/datatable';
import Column from 'primevue/column';
import Button from 'primevue/button';
import 'primevue/resources/themes/bootstrap4-light-blue/theme.css';
import 'primevue/resources/primevue.min.css';
import 'primeicons/primeicons.css';

const appInstance = createApp(App);

appInstance.component('DataTable', DataTable);
appInstance.component('Column', Column);
appInstance.component('Button', Button);
appInstance.use(store);
appInstance.use(router);
appInstance.use(ArgonDashboard);
appInstance.use(PrimeVue);
appInstance.config.globalProperties.axios=axios;
appInstance.config.globalProperties.$log = console.log
appInstance.mount("#app");