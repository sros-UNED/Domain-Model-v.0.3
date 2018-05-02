<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <let name="objectProperties" value="//objectProperty/name"/>
    <let name="classes" value="//class"/>
    <let name="classNames" value="//name"/>
    <pattern>
        <rule context="objectProperty">
            <let name="label" value="for $i in $classes[name = current()/range]/properties/objectProperty[range = current()/../../name]/@corresp 
                return $i"/>
            <assert
                test="
                if (@corresp) then  current()/name = $label 
                    else
                        true()"
                >Eu nom existo como inversa de outra propriedade objecto!</assert>
            <assert test="desc">Falta a descriçom</assert>
        </rule>
        <rule context="dataProperty">
            <assert test="label">Todas as propriedades devem ter umha label</assert>
            <assert test="desc/node()">Falta a descriçom</assert>
            <assert test="@cardinality = ('?', '*')">Valor inválido para a cardinalidade</assert>
            <assert test="@range = ('xs:boolean', 'xs:decimal', 'xs:string', 'xs:anyURI', 'xs:dateTime')">Valor inválido para o @range</assert>
        </rule>
        <rule context="term">
            <assert test=". = $classNames">Erro tipógrafico!</assert>
        </rule>
    </pattern>
</schema>
