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
  (xml-file-to-hash (-> path-string? (listof (cons/c string? (or/c 'v 'a))) hash?))
}

@itemlist[
  @item{Load xml to hash map.}
  @item{Use hierachy to access all the nodes's attribute and content, each item is a pair, cons hierachy 'a or 'v.
        'a means this item is a attribute, 'v means this item is a value.
        '(("list.a.element" . v) ("list.a.attribute" . a))}
  @item{Result is a list of string.}
]

@subsection{Basic Usage}

xml:
@codeblock{
<empty attr1="a1" attr2="a2">v</empty>
}

xml-to-hash:
@codeblock{
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
}

Be careful, if xml is below style, then node "empty"'s value is "".
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

@codeblock{
(let ([xml_hash (xml-file-to-hash "hierachy.xml" '(("level1.level2.level3.attr" . a) ("level1.level2.level3.level4" . v)))])
  (printf "level1.level2.level3.attr: [~a]\n" (hash-ref xml_hash "level1.level2.level3.attr"))

  (printf "level1.level2.level3.level4: [~a]\n" (hash-ref xml_hash "level1.level2.level3.level4"))
)

level1.level2.level3.attr: [(a3)]
level1.level2.level3.level4: [(Hello Xml!)]
}

@subsection{Default Attribute}

If some node has no some attribute, then it get a default "" value.

xml:
@codeblock{
<list>
  <child attr="a1">c1</child>
  <child>c2</child>
  <child attr="a3">c3</child>
</list>
}

@codeblock{
(let ([xml_hash (xml-file-to-hash
                 "default.xml"
                 '(
                   ("list.child.attr" . a)
                   ))])

  (printf "list.child.attr: [~a]\n" (hash-ref xml_hash "list.child.attr"))
)

list.child.attr: [(a1  a3)]

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

@section{lists-to-xml_content}

lists-to-xml_content turn lists to xml without header.
