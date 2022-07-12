<template>

  <div>
    <DataTable :value="customers" :paginator="true" :rows="10"
      paginatorTemplate="CurrentPageReport FirstPageLink PrevPageLink PageLinks NextPageLink LastPageLink RowsPerPageDropdown"
      :rowsPerPageOptions="[10, 20, 50]" responsiveLayout="scroll"
      currentPageReportTemplate="Showing {first} to {last} of {totalRecords}">
      <Column field="Customer_FirstName" header="first name"></Column>
      <Column field="Customer_LastName" header="last name"></Column>
      <Column field="Customer_MI" header="MI"></Column>
      <Column field="CustomerName" header="Customer Name"></Column>
      <Column field="Company" header="Company"></Column>
      <Column field="Email" header="Email"></Column>
      <Column field="VIP" header="is vip?"></Column>
      <Column field="Active" header="is active?"></Column>
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
  name: "customers-table",
  data(){
        return{
          customers:[]
        }
  },
  methods:{
      refreshData(){
          axios.get('https://localhost:44397/api/customer')
          .then((response)=>{
            this.customers=response.data;
          });
      }
  },
  mounted:function(){
    this.refreshData();
  }
}

</script>
<!--https://localhost:44397/api/project-->
