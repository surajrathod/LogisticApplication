import { LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent'

export default class CreateCustomer extends LightningElement {
    handleSuccess(event){
        this.template.querySelectorAll('lightning-input-field').forEach(field=>{
            field.reset();
        });

        const displaymessage = new ShowToastEvent({
            title:"Customer Record Created",
            message:`ID:- ${event.detail.id} was created.`
        })
        this.dispatchEvent(displaymessage);
    }
}