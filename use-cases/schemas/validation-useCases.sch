<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <let name="DM" value="doc('../domain-model/POSTDATA_domain-model_v03.xml')"/>
    <let name="instances" value="//instance"/>
    <pattern>
        <rule context="class">
            <assert test="name = $DM//class/name">Falta el nombre de la clase o este no coincide con
                ninguna de las clases del Domain Model (comprobar 'DomainModel.xml')</assert>
            <assert test="instance">Cada clase (elemento 'class') tiene que contener por lo menos un
                elemento 'instance'</assert>
        </rule>
        <rule context="instance[not(parent::class/name eq 'Opus')]">
            <assert test="label = //instance//range">Mariana, nom te estresses, mas esta instáncia está desvinculada</assert>
        </rule>
        <rule context="instance/label">
            <report test=". = (preceding::label | following::label)">El 'label' de una instancia no puede repetirse</report>
        </rule>
        <rule context="objectProperty">
            <let name="range" value="$instances[label = current()/range]/ancestor::class/name"/>
            <assert
                test="name = $DM//class[name = current()/ancestor::class/name]//objectProperty[range = $range]/name"
                >Este é o valor de <value-of select="$range"/></assert>
            <assert test="range = //instance/label">El valor de 'range' debe coincidir con el nombre de alguna instancia
            ('instance/label')</assert>
        </rule>
        <rule context="dataProperty">
            <assert
                test="name = $DM//class[name = current()/ancestor::class/name]//dataProperty/name"
                >El nombre de esta propiedad no existe en el Domain Model (comprobar
                'DomainModel.xml')</assert>
        </rule>
    </pattern>
</schema>
