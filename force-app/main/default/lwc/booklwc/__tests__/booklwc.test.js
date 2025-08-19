import { createElement } from '@lwc/engine-dom';
import Booklwc from 'c/booklwc';

describe('c-booklwc', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('should render the component with book data', () => {
        const bookData = {
            bookOptions: [
                {
                    name: 'Book 1',
                    author: 'Author 1',
                    year: 2020,
                    rating: 4.5,
                    quantity: 10,
                    bestSeller: true
                }
            ]
        };

        const element = createElement('c-booklwc', {
            is: Booklwc
        });
        element.value = bookData;
        document.body.appendChild(element);

        const title = element.shadowRoot.querySelector('.book-title');
        expect(title.textContent).toBe('Book 1');

        const author = element.shadowRoot.querySelector('.book-author');
        expect(author.textContent).toBe('by Author 1');

        const year = element.shadowRoot.querySelector('.book-year');
        expect(year.textContent).toBe('2020');

        const rating = element.shadowRoot.querySelector('.book-rating');
        expect(rating.textContent).toContain('Rating:');

        const quantity = element.shadowRoot.querySelector('p:nth-child(3)');
        expect(quantity.textContent).toBe('Quantity: 10');

        const bestsellerBadge = element.shadowRoot.querySelector('.bestseller-badge');
        expect(bestsellerBadge.textContent).toBe('Best Seller');
    });

    it('should handle buy button click', () => {
        const bookData = {
            bookOptions: [
                {
                    name: 'Book 1',
                    author: 'Author 1',
                    year: 2020,
                    rating: 4.5,
                    quantity: 10,
                    bestSeller: true
                }
            ]
        };

        const element = createElement('c-booklwc', {
            is: Booklwc
        });
        element.value = bookData;
        document.body.appendChild(element);

        const buyButton = element.shadowRoot.querySelector('.buy-now-button');
        expect(buyButton).not.toBeNull();

        const handler = jest.fn();
        element.addEventListener('buy', handler);

        buyButton.click();

        return Promise.resolve().then(() => {
            expect(handler).toHaveBeenCalled();
            expect(handler.mock.calls[0][0].detail.title).toBe('Book 1');
        });
    });
});