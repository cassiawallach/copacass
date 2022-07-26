<?xml version="1.0"?>
<ruleset name="Custom Rules"
    xmlns="http://pmd.sourceforge.net/ruleset/2.0.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://pmd.sourceforge.net/ruleset/2.0.0 http://pmd.sourceforge.net/ruleset_2_0_0.xsd">
    <description>
		My Custom rules
    </description>
    <!-- Using a single rule from a set of predefined rules -->
	<rule ref="category/apex/bestpractices.xml/AvoidLogicInTrigger" />
    <!-- Using whole set of predefined rules -->
	<rule ref="category/apex/errorprone.xml" />
    <!-- Using whole set of rules excluding some -->
    <rule ref="category/apex/codestyle.xml">
	<exclude name="WhileLoopsMustUseBraces"/>  
  <exclude name="WhileLoopsMustUseBraces"/>  
  <exclude name="WhileLoopsMustUseBraces"/>  
  <exclude name="WhileLoopsMustUseBraces"/>    
    </rule>
    <rule ref="category/apex/bestpractices.xml/AvoidLogicInTrigger" />

    <rule ref="rulesets/basic.xml/BooleanInstantiation" message="Boss wants to talk to you."><priority>5</priority></rule> 
  <rule ref="rulesets/basic.xml/CollapsibleIfStatements">					<priority>5</priority></rule> 
  <rule ref="rulesets/basic.xml/DoubleCheckedLocking">						<priority>5</priority></rule> 
  <rule ref="rulesets/basic.xml/EmptyCatchBlock">							<priority>1</priority></rule> 
  <rule ref="rulesets/basic.xml/EmptyFinallyBlock">							<priority>5</priority></rule> 
  <rule ref="rulesets/basic.xml/EmptyIfStmt">								<priority>1</priority></rule> 
  <rule ref="rulesets/basic.xml/EmptyStatementNotInLoop">					<priority>5</priority></rule> 
  <rule ref="rulesets/basic.xml/EmptyStaticInitializer">					<priority>5</priority></rule> 
  <rule ref="rulesets/basic.xml/EmptySwitchStatements">						<priority>5</priority></rule> 
  <rule ref="rulesets/basic.xml/EmptySynchronizedBlock">					<priority>5</priority></rule> 
  <rule ref="rulesets/basic.xml/EmptyTryBlock">								<priority>5</priority></rule> 
  <rule ref="rulesets/basic.xml/EmptyWhileStmt">							<priority>5</priority></rule> 
  <rule ref="rulesets/basic.xml/ForLoopShouldBeWhileLoop">					<priority>5</priority></rule> 
  <rule ref="rulesets/basic.xml/JumbledIncrementer">						<priority>5</priority></rule> 
  <rule ref="rulesets/basic.xml/OverrideBothEqualsAndHashcode">				<priority>1</priority></rule> 
  <rule ref="rulesets/basic.xml/ReturnFromFinallyBlock">					<priority>5</priority></rule> 
  <rule ref="rulesets/basic.xml/UnconditionalIfStatement">					<priority>5</priority></rule> 
  <rule ref="rulesets/basic.xml/UnnecessaryConversionTemporary">			<priority>5</priority></rule> 
  <rule ref="rulesets/basic.xml/UnnecessaryFinalModifier">					<priority>5</priority></rule> 
  <rule ref="rulesets/basic.xml/UnnecessaryReturn">							<priority>5</priority></rule> 
  <rule ref="rulesets/basic.xml/UselessOverridingMethod">					<priority>5</priority></rule> 
  
  <rule ref="rulesets/clone.xml/CloneMethodMustImplementCloneable">			<priority>1</priority></rule> 
  <rule ref="rulesets/clone.xml/CloneThrowsCloneNotSupportedException">		<priority>5</priority></rule> 
  <rule ref="rulesets/clone.xml/ProperCloneImplementation">					<priority>5</priority></rule> 
 
  <rule ref="rulesets/codesize.xml/CyclomaticComplexity">					<priority>5</priority></rule> 
  <rule ref="rulesets/codesize.xml/ExcessiveClassLength">					<priority>5</priority></rule> 
  <rule ref="rulesets/codesize.xml/ExcessiveMethodLength">					<priority>5</priority></rule> 
  <rule ref="rulesets/codesize.xml/ExcessiveParameterList">					<priority>5</priority></rule> 
  <rule ref="rulesets/codesize.xml/ExcessivePublicCount">					<priority>5</priority></rule> 
  <rule ref="rulesets/codesize.xml/TooManyFields">							<priority>5</priority></rule> 
  
  <rule ref="rulesets/controversial.xml/UnnecessaryConstructor"> 			<priority>5</priority></rule> 
  <rule ref="rulesets/controversial.xml/NullAssignment"> 					<priority>5</priority></rule> 
  
  <rule ref="rulesets/coupling.xml/CouplingBetweenObjects">					<priority>5</priority></rule> 
  <rule ref="rulesets/coupling.xml/ExcessiveImports">						<priority>5</priority></rule> 
  <rule ref="rulesets/coupling.xml/LooseCoupling">							<priority>5</priority></rule> 
  
  <rule ref="rulesets/finalizers.xml/EmptyFinalizer">						<priority>5</priority></rule> 
  <rule ref="rulesets/finalizers.xml/FinalizeOnlyCallsSuperFinalize">		<priority>5</priority></rule> 
  <rule ref="rulesets/finalizers.xml/FinalizeOverloaded">					<priority>5</priority></rule> 
  <rule ref="rulesets/finalizers.xml/FinalizeDoesNotCallSuperFinalize">		<priority>5</priority></rule> 
  <rule ref="rulesets/finalizers.xml/FinalizeShouldBeProtected">			<priority>5</priority></rule> 
  <rule ref="rulesets/finalizers.xml/AvoidCallingFinalize">					<priority>5</priority></rule> 
  
  <rule ref="rulesets/imports.xml/DuplicateImports">						<priority>1</priority></rule> 
  <rule ref="rulesets/imports.xml/DontImportJavaLang">						<priority>5</priority></rule> 
  <rule ref="rulesets/imports.xml/UnusedImports">							<priority>1</priority></rule> 
  <rule ref="rulesets/imports.xml/ImportFromSamePackage">					<priority>5</priority></rule> 
  <rule ref="rulesets/strings.xml/StringToString"> 							<priority>1</priority></rule> 
  <rule ref="rulesets/strings.xml/StringInstantiation"> 					<priority>5</priority></rule> 

  <rule ref="rulesets/sunsecure.xml/MethodReturnsInternalArray">			<priority>5</priority></rule> 
  <rule ref="rulesets/sunsecure.xml/ArrayIsStoredDirectly">					<priority>5</priority></rule> 
  
  <rule ref="rulesets/unusedcode.xml/UnusedLocalVariable">					<priority>1</priority></rule>
  <rule ref="rulesets/unusedcode.xml/UnusedPrivateField">					<priority>1</priority></rule>
  <rule ref="rulesets/unusedcode.xml/UnusedPrivateMethod">					<priority>1</priority></rule>
  <rule ref="rulesets/unusedcode.xml/UnusedFormalParameter">                <priority>1</priority></rule>
    <rule name="DontImportWild" message="Please no wild card imports" class="net.sourceforge.pmd.rules.XPathRule">
    <description>We don't take kindly to imports such as java.net.* round these parts</description>
    <priority>1</priority>
    <properties>
      <property name="xpath">
        <value>
          <![CDATA[/ImportDeclaration[@PackageName=@ImportedName]]]>
        </value>
      </property>
    </properties>
    <example>
    <![CDATA[
    	import java.net.*; //is bad
    	import java.net.URL; //is better
    ]]>
    </example>
  </rule>
</ruleset>