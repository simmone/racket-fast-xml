# Fast-Xml: Simplified XML Parsing and Writing

Use xml-to-hash, specify the element/attribute’s hierach, ie:
"list.a.v", then you can use hash-ref to get xml element/attribute as a
list.

Use lists-to-xml(lists-to-compact\_xml), convert recursive list to
generate xml, remove redundant format, more readable.

Chen Xiao <[chenxiao770117@gmail.com](mailto:chenxiao770117@gmail.com)>

    1 Install              
                           
    2 xml-to-hash          
      2.1 Basic Usage      
      2.2 Hierachy         
      2.3 Default Attribute
                           
    3 lists-to-xml         
                           
    4 lists-to-xml\_content

## 1. Install

raco pkg install fast-xml

## 2. xml-to-hash

```racket
(xml-file-to-hash (-> path-string? (listof (cons/c string? (or/c 'v 'a))) hash?))
```

* Load xml to hash map.

* Use hierachy to access all the nodes’s attribute and content, each
  item is a pair, cons hierachy ’a or ’v. ’a means this item is a
  attribute, ’v means this item is a value. ’\(\("list.a.element" . v\)
  \("list.a.attribute" . a\)\)

* Result is a list of string.

### 2.1. Basic Usage

xml:

```racket
<empty attr1="a1" attr2="a2">v</empty>
```

xml-to-hash:

```racket
(let ([xml_hash (xml-file-to-hash                                  
                 empty2_xml_file                                   
                 '(("empty" "empty.attr1" . a) ("empty.attr2" . a))
                )])                                                
  (printf "xml hash has ~a keys.\n" (hash-count xml_hash))         
                                                                   
  (printf "empty: ~a\n" (hash-ref xml_hash "empty"))               
                                                                   
  (printf "empty.attr1: ~a\n" (hash-ref xml_hash "empty.attr1"))   
                                                                   
  (printf "empty.attr2: ~a\n" (hash-ref xml_hash "empty.attr2"))   
)                                                                  
                                                                   
xml hash has 3 keys.                                               
empty: (v)                                                         
empty.attr1: (a1)                                                  
empty.attr2: (a2)                                                  
```

Be careful, if xml is below style, then node "empty"’s value is "".

```racket
<empty attr1="a1" attr2="a2"/>
```

### 2.2. Hierachy

XML is a hierachy structure text format. So, xml-to-hash refect the
hierachy information. You access a node’s attribute or content, you
should give all the ancester’s name in order.

xml:

```racket
<level1>                         
  <level2>                       
    <level3 attr="a3">           
      <level4>Hello Xml!</level4>
    </level3>                    
  </level2>                      
</level1>                        
```

```racket
(let ([xml_hash (xml-file-to-hash "hierachy.xml" '(("level1.level2.level3.attr" . a) ("level1.level2.level3.level4" . v)))])
  (printf "level1.level2.level3.attr: [~a]\n" (hash-ref xml_hash "level1.level2.level3.attr"))                              
                                                                                                                            
  (printf "level1.level2.level3.level4: [~a]\n" (hash-ref xml_hash "level1.level2.level3.level4"))                          
)                                                                                                                           
                                                                                                                            
level1.level2.level3.attr: [(a3)]                                                                                           
level1.level2.level3.level4: [(Hello Xml!)]                                                                                 
```

### 2.3. Default Attribute

If some node has no some attribute, then it get a default "" value.

xml:

```racket
<list>                       
  <child attr="a1">c1</child>
  <child>c2</child>          
  <child attr="a3">c3</child>
</list>                      
```

```racket
(let ([xml_hash (xml-file-to-hash                                         
                 "default.xml"                                            
                 '(                                                       
                   ("list.child.attr" . a)                                
                   ))])                                                   
                                                                          
  (printf "list.child.attr: [~a]\n" (hash-ref xml_hash "list.child.attr"))
)                                                                         
                                                                          
list.child.attr: [(a1  a3)]                                               
                                                                          
```

## 3. lists-to-xml

```racket
(lists-to-xml list?) -> string?
```

convert lists to xml, the list should obey below rules.

1. First node of list should be a string? or symbol? It represent node
name.

```racket
'("H1") -> <H1/>
```

2. All the pairs represent node’s attributes.

```racket
'("H1" ("attr1" . "1") ("attr2" . "2")) -> <H1 "attr1"="1" "attr2"="2"/>
```

3. If have children, string/symbol represent its value, or, the lists
represents its children.         Node’s children should either string?
or symbol? or lists?, only one of these three types.

```racket
'("H1" "haha") -> <H1>haha</H1>
                               
'("H1" ("H2" "haha")) ->       
                               
  <H1>                         
    <H2>                       
      haha                     
    </H2>                      
  </H1>                        
```

```racket
(lists-to-compact_xml list?) -> string?
```

remove all the format characters.

```racket
'("H1" ("H2" "haha")) -> <H1><H2>haha</H2></H1>
```

## 4. lists-to-xml\_content

lists-to-xml\_content turn lists to xml without header.
