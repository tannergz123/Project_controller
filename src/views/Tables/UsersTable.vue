<template>

  <div>
    <DataTable :value="users" :paginator="true" :rows="10"
      paginatorTemplate="CurrentPageReport FirstPageLink PrevPageLink PageLinks NextPageLink LastPageLink RowsPerPageDropdown"
      :rowsPerPageOptions="[10, 20, 50]" responsiveLayout="scroll"
      currentPageReportTemplate="Showing {first} to {last} of {totalRecords}">
      <Column field="LoginField" header="Login field"></Column>
      <Column field="First_Name" header="First name"></Column>
      <Column field="Last_Name" header="Last name"></Column>
      <Column field="Email" header="Email"></Column>
      <Column field="RoleID" header="Role ID"></Column>
      <Column field="TeamID" header="Team ID"></Column>
      <Column field="userStatus" header="User status"></Column>
      <Column field="Last_updated_by" header="Last updated by:"></Column>
      <Column field="Last_updated_date" header="Last update:"></Column>
      <Column field="password_encrypt" header="Encrypted password"></Column>
      <template #paginatorstart>
        <Button type="button" icon="pi pi-refresh" class="p-button-text" />
      </template>
      <template #paginatorend>
        <Button type="button" icon="pi pi-cloud" class="p-button-text" />
      </template>
    </DataTable>
  </div>

</template>

<script>
import axios from 'axios';
export default {
  name: "users-table",
  data(){
        return{
          users:[]
        }
  },
  methods:{
      refreshData(){
          axios.get('https://localhost:44397/api/users')
          .then((response)=>{
            this.users=response.data;
          });
      }
  },
  mounted:function(){
    this.refreshData();
  }
}

</script>
<!--https://localhost:44397/api/project-->
