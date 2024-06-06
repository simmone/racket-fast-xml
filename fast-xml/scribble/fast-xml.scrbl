#lang scribble/manual

@title{Fast-Xml: Simplified XML Parsing and Writing}

Use xml-to-hash, specify the element/attribute's hierach, ie: "list.a.v", then you can use hash-ref to get xml element/attribute as a list.

Use lists-to-xml(lists-to-compact_xml), convert recursive list to generate xml, remove redundant format, more readable.

@author+email["Chen Xiao" "chenxiao770117@gmail.com"]

@table-of-contents[]

@section{Install}

raco pkg install fast-xml

@section{xml-to-hash}

@codeblock{
  (xml-to-hash (or/c path-string? (listof string?) input-port?)) -> hash?
}

@itemlist[
  @item{Load xml to hash map.}
  @item{Use hierachy to access all the nodes's attribute and content: '("list.a.element" "list.a.attribute")}
  @item{Result is a list of string.}
]

@subsection{Basic Usage}

xml:
@codeblock{
<empty attr1="a1" attr2="a2">
</empty>
}

xml-to-hash:
@codeblock{
(let ([xml_hash (xml-file-to-hash
                 empty2_xml_file
                 '("empty" "empty.attr1" "empty.attr2")
                )])
  (printf "xml hash has ~a keys.\n" (hash-count xml_hash))

  (printf "empty: ~a\n" (hash-ref xml_hash "empty"))

  (printf "empty.attr1: ~a\n" (hash-ref xml_hash "empty.attr1"))

  (printf "empty.attr2: ~a\n" (hash-ref xml_hash "empty.attr2"))
)

xml hash has 3 keys.
empty: '("")
empty.attr1: '("a1")
empty.attr2: '("a2")
}

Be careful, if xml is below style, then node "empty" can't get value.
@codeblock{
<empty attr1="a1" attr2="a2"/>
}

@subsection{Hierachy}

XML is a hierachy structure text format. So, xml-to-hash refect the hierachy information.
You access a node's attribute or content, you should give all the ancester's name in order.

xml:
@codeblock{
<level1>
  <level2>
    <level3 attr="a3">
      <level4>Hello Xml!</level4>
    </level3>
  </level2>
</level1>
}

xml-to-hash:
@codeblock{
(let ([xml_hash (xml-to-hash "hierachy.xml")])
  ;; if each node is the unique, so each node must append serial "1" at the end.
  (printf "level11.level21.level31.attr: [~a]\n" (hash-ref xml_hash "level11.level21.level31.attr"))

  (printf "level11.level21.level31.level41: [~a]\n" (hash-ref xml_hash "level11.level21.level31.level41"))
)

level11.level21.level31.attr: [a3]
level11.level21.level31.level41: [Hello Xml!]
}

@subsection{Count and List}

XML's node can occur once or more than once. So xml-to-hash count all the node.
In result hash, you can get all node's occurence count.

How? Use "'s count" suffix.

xml:
@codeblock{
<list>
  <child attr="a1">c1</child>
  <child attr="a2">c2</child>
  <child attr="a3">c3</child>
</list>
}

xml-to-hash:
@codeblock{
(let ([xml_hash (xml-to-hash "list.xml")])
  (printf "xml hash has ~a pairs.\n" (hash-count xml_hash))

  (printf "list's count: [~a]\n" (hash-ref xml_hash "list's count"))

  (printf "list1.child's count: [~a]\n" (hash-ref xml_hash "list1.child's count"))

  (printf "list1.child1's content: [~a]\n" (hash-ref xml_hash "list1.child1"))
  (printf "list1.child1.attr: [~a]\n" (hash-ref xml_hash "list1.child1.attr"))

  (printf "list1.child2's content: [~a]\n" (hash-ref xml_hash "list1.child2"))
  (printf "list1.child2.attr: [~a]\n" (hash-ref xml_hash "list1.child2.attr"))

  (printf "list1.child3's content: [~a]\n" (hash-ref xml_hash "list1.child3"))
  (printf "list1.child3.attr: [~a]\n" (hash-ref xml_hash "list1.child3.attr")))

xml hash has 8 pairs.
list's count: [1]
list1.child's count: [3]
list1.child1's content: [c1]
list1.child1.attr: [a1]
list1.child2's content: [c2]
list1.child2.attr: [a2]
list1.child3's content: [c3]
list1.child3.attr: [a3]
}

In above example, you can use "'s count" suffix to get each node's occurences.

Append serial maybe let the code not so readable, but the benefit is we can use loop to traverse all node list.

By node count and node appended serial.

@codeblock{
  (let loop ([index 1])
    (when (<= index (hash-ref xml_hash "list1.child's count"))
      (printf "child[~a]'s attr:[~a] and content:[~a]\n"
              index
              (hash-ref xml_hash (format "list1.child~a.attr" index))
              (hash-ref xml_hash (format "list1.child~a" index)))
      (loop (add1 index))))

child[1]'s attr:[a1] and content:[c1]
child[2]'s attr:[a2] and content:[c2]
child[3]'s attr:[a3] and content:[c3]
}

@section{lists-to-xml}

@codeblock{
  (lists-to-xml list?) -> string?
}

convert lists to xml, the list should obey below rules.

1. First node of list should be a string? or symbol? It represent node name.

    @codeblock{
     '("H1") -> <H1/>
    }

2. All the pairs represent node's attributes.

    @codeblock{
     '("H1" ("attr1" . "1") ("attr2" . "2")) -> <H1 "attr1"="1" "attr2"="2"/>
    }

3. If have children, string/symbol represent its value, or, the lists represents its children. 
        Node's children should either string? or symbol? or lists?, only one of these three types.

   @codeblock{
   '("H1" "haha") -> <H1>haha</H1>

   '("H1" ("H2" "haha")) ->

     <H1>
       <H2>
         haha
       </H2>
     </H1>
   }

@codeblock{
  (lists-to-compact_xml list?) -> string?
}

remove all the format characters.

@codeblock{
   '("H1" ("H2" "haha")) -> <H1><H2>haha</H2></H1>
}

@section{lists-to-xml_content and xml-trim}

lists-to-xml_content turn lists to xml without header.

xml-trim to generate compact xml.

these two function be combined together to generate the main functions.
