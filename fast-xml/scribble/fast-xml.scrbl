#lang scribble/manual

@title{Fast-Xml: Simplified XML Parsing and Writing}

Use xml-to-hash, specify the element/attribute's hierach, ie: "list.a.v", then you can use hash-ref to get xml element/attribute.

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
  @item{Specify a hierachy string list to get value or attribute:
        '("list.a.element" "list.a.attribute")}
  @item{Result is a string.}
  @item{Node value vs Attribute, If node value is null: ></ or />, node value is "", if attribute not exist, value is not exist in result map too.}
  @item{Every parent node has a "xxx's count" value, tells this level's node's count.}
  @item{Use sequence appended after node name to get value or attribute}
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
                 '(
                   "empty"
                   "empty.attr1"
                   "empty.attr2"
                   )
                )])

  (printf "xml hash has ~a keys.\n" (hash-count xml_hash))

  (printf "empty's count: ~a\n" (hash-ref xml_hash "empty's count"))

  (printf "empty's value: ~a\n" (hash-ref xml_hash "empty1"))

  (printf "empty.attr1: ~a\n" (hash-ref xml_hash "empty1.attr11"))

  (printf "empty.attr2: ~a\n" (hash-ref xml_hash "empty1.attr21")))

xml hash has 4 keys.
empty's count: 1
empty's value: v
empty.attr1: a1
empty.attr2: a2
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
(let ([xml_hash (xml-file-to-hash
                 "hierachy.xml"
                 '(
                   "level1.level2.level3.attr"
                   "level1.level2.level3.level4"
                   ))])

  (printf "level1.level2.level3.attr: [~a]\n" (hash-ref xml_hash "level11.level21.level31.attr1"))

  (printf "level1.level2.level3.level4: [~a]\n" (hash-ref xml_hash "level11.level21.level31.level41"))
)

level1.level2.level3.attr: [a3]
level1.level2.level3.level4: [Hello Xml!]
}

@subsection{Default Attribute}

If some node has no some attribute, then the value is not exists.

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
                   "list.child.attr"
                   ))])

  (printf "list1.child1.attr1: [~a]\n" (hash-ref xml_hash "list1.child1.attr1"))

  (printf "list1.child1.attr2: [~a]\n" (hash-ref xml_hash "list1.child1.attr2" ""))
)

list1.child1.attr1: [a1]
list1.child1.attr2: []
}

@subsection{Entity Convert}

There are two kinds of entity:

1. numeric character reference

    &#xhhhh; or  &#nnnn;

   where the x must be lowercase in XML documents, hhhh is the code point in hexadecimal form, and nnnn is the code point in decimal form. 

2. 5 predefined name
 
  &name;

@codeblock{
  &amp;[&], &lt;[<], &gt;[>], &apos;['], and &quot;["].
}

when reading from xml, attributes and values will be convert from entity to specific character.

when writing to xml, in attributes and values, 5 special chars will be converted to entity string.

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
