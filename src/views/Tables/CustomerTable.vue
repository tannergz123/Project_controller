<template>

  <div>
      <Button label="Create New Customer"  @click="openCreateDialog"/>
      <Dialog  position='topright' header="Fill in information to register new customer" v-model:visible="displayCreateModal" :breakpoints="{'960px': '75vw', '640px': '90vw'}" :style="{width: '70vw'}" :modal="true">
          <div class="container">
            
            <div class="row">
              <div class="col">
                  <p>First Name</p>
                  <p>Middle Name</p>
                  <p>Company</p>
                  <p>Password</p>
              </div>
              
              <div class="col">
                  <InputText id="firstName" type="text" v-model="valueFN" />
                  <InputText id="firstName" type="text" v-model="valueMN" />
                  <InputText id="firstName" type="text" v-model="valueCMPY" />
                  <InputText id="firstName" type="text" v-model="valuePSWD" />
              </div>
              
              <div class="col">
                  <p>Last Name</p>
                  <p>CustomerName</p>
                  <p>Email</p>
              </div>
              
              <div class="col">
                <InputText id="firstName" type="text" v-model="valueLN" />
                <InputText id="firstName" type="text" v-model="valueCN" />
                <InputText id="firstName" type="text" v-model="valueEML" />
              </div>

            </div>
          </div>

          <template #footer>
              <Button label="Create Customer" @click="createCustomer" class="p-button-text"/>

          </template>
      </Dialog>
      
      <Button label="Update Customer"  @click="openUpdateDialog"/>
      <Dialog  position='topright' header="Fill in information to update new user" v-model:visible="displayUpdateModal" :breakpoints="{'960px': '75vw', '640px': '90vw'}" :style="{width: '70vw'}" :modal="true">
          <div class="container">
            
            <div class="row">
              <div class="col">
                  <p>Insert ID to update:</p> 
                  <p>First Name</p>
                  <p>Middle Name</p>
                  <p>Company</p>
                  <p>VIP?</p>
              </div>
              
              <div class="col">
                  <InputText id="firstName" type="text" v-model="valueCID" />
                  <InputText id="firstName" type="text" v-model="valueFN" />
                  <InputText id="firstName" type="text" v-model="valueMN" />
                  <InputText id="firstName" type="text" v-model="valueCMPY" />
                  <Dropdown v-model="selectedVIP" :options="yORn" optionLabel="name" placeholder="yes or no" />
              </div>
              
              <div class="col">
                  <p>Last Name</p>
                  <p>CustomerName</p>
                  <p>Email</p>
                  <p>Active?</p>
              </div>
              
              <div class="col">
                <InputText id="firstName" type="text" v-model="valueLN" />
                <InputText id="firstName" type="text" v-model="valueCN" />
                <InputText id="firstName" type="text" v-model="valueEML" />
                <Dropdown v-model="selectedActive" :options="yORn" optionLabel="name" placeholder="yes or no" />
              </div>

            </div>
          </div>

          <template #footer>
              <Button label="Update Customer" @click="updateCustomer" class="p-button-text"/>

          </template>
      </Dialog>

    </div>


  <div>
    <DataTable :value="customers" :paginator="true" :rows="10"
      paginatorTemplate="CurrentPageReport FirstPageLink PrevPageLink PageLinks NextPageLink LastPageLink RowsPerPageDropdown"
      :rowsPerPageOptions="[10, 20, 50]" responsiveLayout="scroll"
      currentPageReportTemplate="Showing {first} to {last} of {totalRecords}">
      <Column field="Cust_ID" header="Customer ID"></Column>
      <Column field="Customer_FirstName" header="first name"></Column>
      <Column field="Customer_LastName" header="last name"></Column>
      <Column field="Customer_MI" header="MI"></Column>
      <Column field="CustomerName" header="Customer Name"></Column>
      <Column field="Company" header="Company"></Column>
      <Column field="Email" header="Email"></Column>
      <Column field="VIP" header="is vip?"></Column>
      <Column field="Active" header="is active?"></Column>
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
          customers:[],
          displayCreateModal:null,
          displayUpdateModal:null,
          valueFN:null,
          valueMN:null,
          valueLN:null,
          valueCMPY:null,
          valuePSWD:null,
          valueCN:null,
          valueEML:null,
          valueCID:null,
          selectedActive: null,
          selectedVIP:null,
          yORn: [
            {name: 'Yes', value: true},
            {name: 'No', value: false}]
        }
  },
  methods:{
      refreshData(){
          axios.get('https://localhost:44397/api/customer')
          .then((response)=>{
            this.customers=response.data;
          });
      },
      openCreateDialog(){
      this.displayCreateModal=true;
      },
      openUpdateDialog(){
        this.displayUpdateModal=true;
      },
      createCustomer(){
        axios.post('https://localhost:44397/api/customer',{
        Customer_FirstName:this.valueFN,
        Customer_LastName:this.valueLN,
        Customer_MI:this.valueMN,
        CustomerName:this.valueCN,
        Company:this.valueCMPY,
        Email:this.valueEML,
        VIP:0,
        Active:1,
        Password_encrypt:this.valuePSWD
      }).then((response)=>{
          this.refreshData;
          alert(response.data);
        });

      },
      updateCustomer(){
        console.log(this.selectedActive.value)
        console.log(this.selectedActive)
        axios.put('https://localhost:44397/api/customer',{
        Customer_FirstName:this.valueFN,
        Customer_LastName:this.valueLN,
        Customer_MI:this.valueMN,
        CustomerName:this.valueCN,
        Company:this.valueCMPY,
        Email:this.valueEML,
        VIP:this.selectedVIP.value,
        Active:this.selectedActive.value,
        Cust_ID:this.valueCID,
        Password_encrypt:this.valuePSWD
      }).then((response)=>{
          this.refreshData;
          alert(response.data);
        });

      }
  },
  mounted:function(){
    this.refreshData();
  }
}

</script>
<!--https://localhost:44397/api/project-->
