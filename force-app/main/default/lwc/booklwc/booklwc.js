import { LightningElement, api } from 'lwc';

export default class Booklwc extends LightningElement {
    books = [];

    _value;

    @api
    get value() {
        return this._value;
    }

    set value(value) {
        this._value = value;
    }

    connectedCallback() {
        try {
            if (this.value) {
                this.books = this.value.bookOptions.map(record => {
                    const fullStars = Math.floor(record.rating);
                    const halfStars = record.rating - fullStars >= 0.5;
                    const stars = [];

                    for (let i = 0; i < fullStars; i++) {
                        stars.push({ key: `${record.name}-star-${i}`, icon: 'utility:favorite' });
                    }

                    if (halfStars) {
                        stars.push({ key: `${record.name}-half`, icon: 'utility:favorite_half' });
                    }

                    while (stars.length < 5) {
                        stars.push({ key: `${record.name}-empty-${stars.length}`, icon: 'utility:favorite_outline' });
                        }

                    return {
                        ...record,
                        stars,
                        isBestseller: record.bestSeller
                    };
                });
            }
        } catch (error) {
            console.error('Error in connectedCallback:', error);
        }
    }

    handleBuy(event) {
        const bookTitle = event.target.dataset.title;
        console.log('Buy clicked for:', bookTitle);

        // Optionally, dispatch a custom event
        this.dispatchEvent(new CustomEvent('buy', {
            detail: { title: bookTitle }
        }));
    }
}
