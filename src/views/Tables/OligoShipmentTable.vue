<template>
    <div>
        <DataTable :value="oligoShipments" :paginator="true" :rows="10"
            paginatorTemplate="CurrentPageReport FirstPageLink PrevPageLink PageLinks NextPageLink LastPageLink RowsPerPageDropdown"
            :rowsPerPageOptions="[10, 20, 50]" responsiveLayout="scroll"
            currentPageReportTemplate="Showing {first} to {last} of {totalRecords}">
            <Column field="Shipment_ID" header="Shipment ID"></Column>
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


export default {
    methods: {
        testLog() {
            this.console.log("test")
        }
    },
    name: "oligoShipments-table",
    components: {
    },
    data() {
        return {
            oligoShipments: []
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

