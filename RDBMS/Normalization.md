# Normalization
Normalization rules are designed to prevent update anomalies and data inconsistencies. With respect to performance tradeoffs, these guidelines are biased toward the assumption that all non-key fields will be updated frequently. They tend to penalize retrieval, since data which may have been retrievable from one record in an unnormalized design may have to be retrieved from several records in the normalized form. There is no obligation to fully normalize all records when actual performance requirements are taken into account. 

#### First Normal Form
First normal form deals with the "shape" of a record type. Under first normal form, all occurrences of a record type must contain the same number of fields. First normal form excludes variable repeating fields and groups. This is not so much a design guideline as a matter of definition. Relational database theory doesn't deal with records having a variable number of fields.  

#### Second Normal Form
In order to be in second normal form, data should be in first normal form and all non key value should depend on a key value or composite value. In another word, there should not be partial dependencies.

#### Third Normal Form
In order to be third normal form, data should be in second normal form and there is no transitive dependency. In another word, each non key value should be idetifiable by key value only. To summarize, a record is in second and third normal forms if every field is either part of the key or provides a (single-valued) fact about exactly the whole key and nothing else. 

