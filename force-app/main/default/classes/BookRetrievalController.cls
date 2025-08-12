Public class BookRetrievalController {
    
        @InvocableMethod(label='Retrieve Books' description = 'Fetch all the books from the system')
  		Public static List<BookResponse>getBooks(List<BookRequest> req){
    
            List<BookResponse> responses = new List<BookResponse>();
            BookResponse res = new BookResponse();
            res.abookOptions = new AvailableBooks();
            res.abookOptions.bookOptions = new List<Book>();        
            
            for(Books__c objbk :[select Id, Name, Quantity__c, Author__c, Best_Seller__c, Rating__c, Year__c  from Books__c ]){
                 Book bookconst = new Book(objbk.Name, objbk.Author__c, objbk.Best_Seller__c, Integer.valueOf(objbk.Year__c),
                                        String.valueOf(objbk.Rating__c), Integer.valueOf(objbk.Quantity__c) );    
                
               		res.abookOptions.bookOptions.add(bookconst);
                }
             	responses.add(res);
             	return responses;
        }
    
            Public class BookRequest{
            	@InvocableVariable 
                Public String bookName;
            }
            
            Public class BookResponse{
           	@InvocableVariable 
           	Public AvailableBooks abookOptions;
            }
            
            Public class AvailableBooks{
            	Public List<Book> bookOptions;
            }

        Public class Book{
                @InvocableVariable Public String name;
                @InvocableVariable Public String author;
                @InvocableVariable Public Boolean bestSeller;
                @InvocableVariable Public Integer year;
                @InvocableVariable Public String rating;
                @InvocableVariable Public Integer quantity;
                
       	 	Public Book (String name, String author, Boolean bestSeller, Integer year, String rating, Integer quantity){
                this.name = name; 
                this.author = author; 
                this.bestSeller = bestseller; 
                this.year = year;
                this.rating = rating; 
                this.quantity = quantity;
                }
	}
}