<template>

  <div>
    <Button label="Create New User"  @click="openCreateDialog"/>
        <Dialog  position='topright' header="Fill in information to register new user" v-model:visible="displayModal" :breakpoints="{'960px': '75vw', '640px': '90vw'}" :style="{width: '70vw'}" :modal="true">
            <div class="container">
              
              <div class="row">
                <div class="col">
                   <p>First Name</p> 
                   <p>Role ID</p> 
                   <p>Login username</p> 
                   <p>Password</p> 
                   
                </div>
                <div class="col">
                   <InputText id="firstName" type="text" v-model="valueFN" />
                   <InputNumber id="integeronly"  v-model="valueRID" placeholder="numbers only please" />
                   <InputText id="loginField" type="text" v-model="valueLGNF" />
                   <InputText id="password" type="text" v-model="valuePSWD" />
                </div>
                <div class="col">
                   <p>Last Name</p>
                   <p>Team ID</p>  
                   <p>Email</p> 
                </div>
                <div class="col">
                   <InputText id="lastName" type="text" v-model="valueLN" />
                   <InputNumber id="integeronly" type="text" v-model="valueTID" placeholder="numbers only please"/>
                   <InputText id="email" type="text" v-model="valueEM" />
                </div>
              </div>
            </div>

            <template #footer>
                <Button label="Create User" @click="userCreation" class="p-button-text"/>

            </template>
        </Dialog>

        <Button label="Update User"  @click="openUpdateDialog"/>
            <Dialog  position='topright' header="Fill in information to update user" v-model:visible="displayModal2" :breakpoints="{'960px': '75vw', '640px': '90vw'}" :style="{width: '70vw'}" :modal="true">
            <div class="container">
              
              <div class="row">
                <div class="col">
                   <p>Type in login to change</p> 
                   <p>First Name</p> 
                   <p>Role ID</p> 
                   <p>Status</p>
                   
                </div>
                <div class="col">
                   <InputText id="3" type="text" v-model="valueLGNF" />
                   <InputText id="1" type="text" v-model="valueFN" />
                   <InputNumber id="2"  v-model="valueRID" placeholder="numbers only please" />
                   <InputText id="4" type="text" v-model="valueStatus" />
                </div>
                <div class="col">
                   <p>Last Name</p>
                   <p>Team ID</p>  
                   <p>Email</p> 
                </div>
                <div class="col">
                   <InputText id="5" type="text" v-model="valueLN" />
                   <InputNumber id="6" type="text" v-model="valueTID" placeholder="numbers only please"/>
                   <InputText id="7" type="text" v-model="valueEM" />
                </div>
              </div>
            </div>

              <template #footer>
                  <Button label="Update User" @click="userUpdate" class="p-button-text"/>

              </template>
            </Dialog>

  </div>

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
          users:[],
          displayModal:false,
          displayModal2:false,
          valueFN:null,
          valueLN:null,
          valueRID:null,
          valueTID:null,
          valueLGNF:null,
          valueEM:null,
          valuePSWD:null,
          valueStatus:null
        }
  },
  methods:{
      refreshData(){
          axios.get('https://localhost:44397/api/users')
          .then((response)=>{
            this.users=response.data;
          });
      },
      openCreateDialog() {
            this.displayModal = true;
        },
      openUpdateDialog(){
            this.displayModal2=true;
      },
      userCreation(){
        console.log("console log:"+this.valueFN);
        
        axios.post('https://localhost:44397/api/users',{
          First_Name:this.valueFN,
          Last_Name:this.valueLN,
          LoginField:this.valueLGNF,
          password_encrypt:this.valuePSWD,
          RoleID:this.valueRID,
          TeamID:this.valueTID,
          Email:this.valueEM,
          userStatus:"Active"
        }).then((response)=>{
          this.refreshData;
          alert(response.data);
        });
      },
      userUpdate(){
        axios.put('https://localhost:44397/api/users',{
          First_Name:this.valueFN,
          Last_Name:this.valueLN,
          LoginField:this.valueLGNF,
          password_encrypt:this.valuePSWD,
          RoleID:this.valueRID,
          TeamID:this.valueTID,
          Email:this.valueEM,
          userStatus:this.valueStatus

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
