<template>

    <div>
      <Button label="Create New Oligo Shipment"  @click="openCreateOligShip"/>
      <Dialog  position='topright' header="Fill in information to create new shipment" v-model:visible="displayCreateModal" :breakpoints="{'960px': '75vw', '640px': '90vw'}" :style="{width: '70vw'}" :modal="true">
          <div class="container">
            
            <div class="row">
              <div class="col">
                  <p>Carrier</p>
                  <p>Shipping To:</p>
                  <p>Void?</p>
                  <p>Notes</p>
              </div>
              
              <div class="col">
                  <InputText id="carrier" type="text" v-model="valueCarrier" />
                  <InputText id="shipTO" type="text" v-model="valueShipTO" />
                  <Dropdown v-model="voidSelect" :options="yORn" optionLabel="name" placeholder="yes or no" />
                  <InputText id="note" type="text" v-model="valueNote" />
              </div>
              
              <div class="col">
                  <p>Tracking:</p>
                  <p>Shipping Date</p>
                  <p>Number of Plates</p>
              </div>
              
              <div class="col">
                <InputText id="tracker" type="text" v-model="valueTracker" />
                <InputText id="shipDate" type="date" v-model="valueShipDate" />
                <InputText id="plateNO" type="text" v-model="valuePltNo" />
              </div>

            </div>
          </div>

          <template #footer>
              <Button label="Create Shipment" @click="createShipment" class="p-button-text"/>

          </template>
      </Dialog>
      
      <Button label="Update Oligo Shipment"  @click="openUpdateOligShip"/>
      <Dialog  position='topright' header="Fill in information to update new user" v-model:visible="displayUpdateModal" :breakpoints="{'960px': '75vw', '640px': '90vw'}" :style="{width: '70vw'}" :modal="true">
          <div class="container">
            
            <div class="row">
              <div class="col">
                  <p>Insert ID to update</p>
                  <p>Shipping To:</p>
                  <p>Void?</p>
                  <p>Notes</p>
              </div>
              
              <div class="col">
                  <InputText id="oligID" type="text" v-model="valueOID" />
                  <InputText id="shipTO" type="text" v-model="valueShipTO" />
                  <Dropdown v-model="voidSelect" :options="yORn" optionLabel="name" placeholder="yes or no" />
                  <InputText id="note" type="text" v-model="valueNote" />
              </div>
              
              <div class="col">
                  <p>Carrier</p>
                  <p>Tracking:</p>
                  <p>Shipping Date</p>
                  <p>Number of Plates</p>
              </div>
              
              <div class="col">
                <InputText id="carrier" type="text" v-model="valueCarrier" />
                <InputText id="tracker" type="text" v-model="valueTracker" />
                <InputText id="shipDate" type="date" v-model="valueShipDate" />
                <InputText id="plateNO" type="text" v-model="valuePltNo" />
              </div>

            </div>
          </div>

          <template #footer>
              <Button label="Update Customer" @click="updateShipment" class="p-button-text"/>

          </template>
      </Dialog>

    </div>
    
    <div>
        <DataTable :value="oligoShipments" :paginator="true" :rows="10"
            paginatorTemplate="CurrentPageReport FirstPageLink PrevPageLink PageLinks NextPageLink LastPageLink RowsPerPageDropdown"
            :rowsPerPageOptions="[10, 20, 50]" responsiveLayout="scroll"
            currentPageReportTemplate="Showing {first} to {last} of {totalRecords}">
            <Column field="Shipping_ID" header="Shipment ID"></Column>
            <Column field="Carrier" header="Carrier"></Column>
            <Column field="Ship_To" header="Ship To"></Column>
            <Column field="Tracking" header="Tracking"></Column>
            <Column field="ShipDate" header="Ship Date"></Column>
            <Column field="ShipNote" header="Ship Note"></Column>
            <Column field="IsOligo" header="Is Oligo"></Column>
            <Column field="NoOfPlates" header="No. of Plates"></Column>
            <Column field="IsVoid" header="Is Void"></Column>
            <Column field="Last_Updated_By" header="Last Updated By"></Column>
            <Column field="Last_Updated_Date" header="Last Updated Date"></Column>
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
import ProjectService from '../../API/ProjectService';
import axios from 'axios';

export default {
    methods: {
        testLog() {
            this.console.log("test")

        },
        openCreateOligShip(){
        this.displayCreateModal=true;
        },
        openUpdateOligShip(){
            this.displayUpdateModal=true;
        },
        createShipment(){

            axios.post('https://localhost:44397/api/oligoShipment',{
                Carrier:this.valueCarrier,
                Ship_To:this.valueShipTO,
                Tracking:this.valueTracker,
                ShipDate:this.valueShipDate,
                NoOfPlates:this.valuePltNo,
                ShipNote:this.valueNote,
                isVoid:this.voidSelect.value

            }).then((response)=>{
                this.refreshData;
                alert(response.data);
            });
        },
        updateShipment(){
            axios.put('https://localhost:44397/api/oligoShipment',{
                Carrier:this.valueCarrier,
                Ship_To:this.valueShipTO,
                Tracking:this.valueTracker,
                ShipDate:this.valueShipDate,
                NoOfPlates:this.valuePltNo,
                ShipNote:this.valueNote,
                isVoid:this.voidSelect.value,
                Shipping_ID:this.valueOID

            }).then((response)=>{
                this.refreshData;
                alert(response.data);
            });
        }
    },
    name: "oligoShipments-table",
    components: {
    },
    data() {
        return {
            oligoShipments: [],
            displayCreateModal:false,
            displayUpdateModal:false,
            valueCarrier:null,
            valueShipTO:null,
            valueVD:null,
            valueNote:null,
            valueTracker:null,
            valueShipDate:null,
            valuePltNo:null,
            voidSelect:null,
            valueOID:null,
            yORn: [
            {name: 'Yes', value: true},
            {name: 'No', value: false}]

        }
    },
    projectService: null,
    created() {
        this.projectService = new ProjectService();
    },
    mounted() {
        this.axios.get('https://localhost:44397/api/oligoShipment')
            .then(res => {
                this.oligoShipments = res.data;
            });
    }
}

</script>

