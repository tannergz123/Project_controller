<template>
  <div class="mt-4 row">

      <div>
      <Button label="Create New Project"  @click="openCreateDialog"/>
      <Dialog  position='topright' header="Fill in information to create new project" v-model:visible="displayCreateModal" :breakpoints="{'960px': '75vw', '640px': '90vw'}" :style="{width: '70vw'}" :modal="true">
          <div class="container">
            
            <div class="row">
              <div class="col">
                  <p>GS Number</p>
                  <p>Customer ID(optional)</p>
              </div>
              
              <div class="col">
                  <InputText id="gsNum" type="text" v-model="valueGSNum" />
                  <InputText id="custID" type="text" v-model="valueCID" />
              </div>
              
              <div class="col">
                  <p>Order Date</p>
                  <p>Note</p>
              </div>
              
              <div class="col">
                <InputText id="orderDate" type="date" v-model="valueOrderD" />
                <InputText id="note" type="text" v-model="valueNote" />
              </div>

            </div>
          </div>

          <template #footer>
              <Button label="Create Project" @click="createProj" class="p-button-text"/>

          </template>
      </Dialog>

      <Button label="Update Project"  @click="openUpdateDialog"/>
      <Dialog  position='topright' header="Fill in information to update new project" v-model:visible="displayUpdateModal" :breakpoints="{'960px': '75vw', '640px': '90vw'}" :style="{width: '70vw'}" :modal="true">
          <div class="container">
            
            <div class="row">
              <div class="col">
                  <p>Insert project ID to update </p>
                  <p>GS Number</p>
                  <p>Status </p>
                  <p>Customer ID</p>
              </div>
              
              <div class="col">
                  <InputText id="projID" type="text" v-model="valuePID" />
                  <InputText id="gsNum" type="text" v-model="valueGSNum" />
                  <InputText id="status" type="text" v-model="valueStatus" />
                  <InputText id="custID" type="text" v-model="valueCID" />
              </div>
              
              <div class="col">
                  <p>Delivery Date</p>
                  <p>Oligo Date </p>
                  <p>Completion Date </p>
                  <p>Note</p>
              </div>
              
              <div class="col">
                <InputText id="deliverDate" type="date" v-model="valueDelivD" />
                <InputText id="oligDate" type="date" v-model="valueOligD" />
                <InputText id="complDate" type="date" v-model="valueComplD" />
                <InputText id="note" type="text" v-model="valueNote" />
              </div>

            </div>
          </div>

          <template #footer>
              <Button label="Update Project" @click="updateProj" class="p-button-text"/>

          </template>
      </Dialog>
    </div>


    <div>
      <DataTable :value="projects" :paginator="true" :rows="10"
        paginatorTemplate="CurrentPageReport FirstPageLink PrevPageLink PageLinks NextPageLink LastPageLink RowsPerPageDropdown"
        :rowsPerPageOptions="[10, 20, 50]" responsiveLayout="scroll"
        currentPageReportTemplate="Showing {first} to {last} of {totalRecords}">
        <Column field="ProjectID" header="Project ID"></Column>
        <Column field="GSNumber" header="GS Number"></Column>
        <Column field="OrderDate" header="Order Date"></Column>
        <Column field="OligoDate" header="Oligo Date"></Column>
        <Column field="DeliverDate" header="Deliver Date"></Column>
        <Column field="ProjectStatus" header="Project Status"></Column>
        <Column field="Note" header="Note"></Column>
        <Column field="CompleteDate" header="Complete Date"></Column>
        <Column field="CustomerID" header="Customer ID"></Column>
        <template #paginatorstart>
          <Button type="button" icon="pi pi-refresh" class="p-button-text" />
        </template>
        <template #paginatorend>
          <Button type="button" icon="pi pi-cloud" class="p-button-text" />
        </template>
      </DataTable>
    </div>
  </div>
</template>

<script>
import ProjectService from '../../API/ProjectService';
import axios from 'axios';

export default {

  name: "projects-table",
  components: {
  },

  data() {
    return {
      projects: [],
      displayCreateModal:false,
      displayUpdateModal:false,
      valueGSNum:null,
      valueNote:null,
      valueOrderD:null,
      valueCID:null,
      valuePID:null,
      valueComplD:null,
      valueOligD:null,
      valueStatus:null,
      valueDelivD:null
    }
  },
  projectService: null,
  created() {
    this.projectService = new ProjectService();
  },
  mounted() {
    this.axios.get('https://localhost:44397/api/project')
      .then(res => {
        this.projects = res.data;
      });
    // fetch('https://localhost:44397/api/project')
    //   .then(data => this.projects = data[0])
    //   .then(res => { res.json() })
    //   .then(console.log("this is projects", this.projects))
    //   .catch(console.error);
  },
  methods:{
      openCreateDialog(){
      this.displayCreateModal=true;
    },
    openUpdateDialog(){
      this.displayUpdateModal=true;
    },
    createProj(){
      console.log(this.valueOD);
      axios.post('https://localhost:44397/api/project',{
        GSNumber:this.valueGSNum,
        OrderDate:this.valueOrderD,
        CustomerID:this.valueCID,
        Note:this.valueNote

      }).then((response)=>{
          this.refreshData;
          alert(response.data);
        });
    },
    updateProj(){
      

      console.log(this.valueDelivD,this.valueOligD,this.valueComplD)

      axios.put('https://localhost:44397/api/project',{
        ProjectID:this.valuePID,
        CompleteDate:this.valueComplD,
        OligoDate:this.valueOligD,
        DeliverDate:this.valueDelivD,
        GSNumber:this.valueGSNum,
        CustomerID:this.valueCID,
        ProjectStatus:this.valueStatus,
        Note:this.valueNote

      }).then((response)=>{
          this.refreshData;
          alert(response.data);
        });
    }
  }
}

</script>
<!--https://localhost:44397/api/project-->
       
