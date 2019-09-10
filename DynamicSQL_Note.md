## Why Dynamic SQL?
It might as well be said directly: solutions with dynamic SQL require more from you as a programmer. Not only in skill, but foremost in discipline and understanding of what you are doing. Dynamic SQL is a wonderful tool when used correctly, but in the hands of the unexperienced it far too often leads to solutions that are flawed and hopeless to maintain.

### That said, the main advantages with dynamic SQL are:

Dynamic SQL gives you a lot more flexibility; as the complexity of the requirements grows, the complexity of the code tends to grow linearly or less than so.
Query plans are cached by the query string, meaning that commonly recurring search criterias will not cause unnecessary recompilations.

### The disadvantages with dynamic SQL are:

1. I said above, poor coding discipline can lead to code that is difficult to maintain.
2. Dynamic SQL introduces a level of difficulty from the start, so for problems of low to moderate complexity, it's a bit of too heavy artillery.
Because queries are built dynamically, 
3. testing is more difficult, and some odd combination of parameters can prove to yield a syntax error when a poor user tries it.
4. You need to consider permissions on the tables accessed by the dynamic SQL since users do not get permission just because the code in a stored procedure; it does not work that way.
   Caching is not always what you want; sometimes you want different plans for different values of the same set of input parameters
