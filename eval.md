# Linked List Evaluation
## Key Takeaways
### Testing
Introduce the necessary abstractions to your tests so that they are sheltered from change.

Example:
- Define a 'append' method in the ListTest class that you use to append nodes to the list in your tests.  That way, if you change List#append, your tests that don't all break. You'd only have to make changes in one place.

### Encapsulation
Identify repeated use of iteration with a certain context. Instead, write a custom iterator that accepts a block.
