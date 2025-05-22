exec msdb.dbo.sp_send_dbmail
	@profile_name = 'Jalol',
	@recipients  = 'matqurbanovahulkar@gmail.com',
	@subject = 'Yo, whats up',
	@body= '
    <deploymentStatus>Deployed</deploymentStatus>

// Define the fields within the big object
    <fields>
        <fullName>Purchase__c</fullName>
        <label>Purchase</label>
        <length>16</length>
        <required>false</required>
        <type>Text</type>
        <unique>false</unique>
    </fields>
    
    <fields>
        <fullName>Order_Number__c</fullName>
        <label>Order Number</label>
        <length>16</length>
        <required>false</required>
        <type>Text</type>
        <unique>true</unique>
    </fields>
    
    <fields>
        <fullName>Platform__c</fullName>
        <label>Platform</label>
        <length>16</length>
        <required>true</required>
        <type>Text</type>
        <unique>false</unique>
    </fields>

    <fields>
        <fullName>Account__c</fullName>
        <label>User Account</label>
        <referenceTo>Account</referenceTo>
        <relationshipName>User_Account</relationshipName>
        <required>true</required>
        <type>Lookup</type>
    </fields>

    <fields>
        <fullName>Order_Date__c</fullName>
        <label>Order Date</label>
        <required>true</required>
        <type>DateTime</type>
    </fields>

// Define the index
    <indexes>
        <fullName>CustomerInteractionsIndex</fullName>
        <label>Customer Interactions Index</label>
        <fields>
            <name>Account__c</name>
            <sortDirection>DESC</sortDirection>
        </fields>
        <fields>
            <name>Platform__c</name>
            <sortDirection>ASC</sortDirection>
        </fields>
        <fields>
            <name>Order_Date__c</name>
            <sortDirection>DESC</sortDirection>
        </fields>
    </indexes>
    
    <label>Customer Interaction</label>
    <pluralLabel>Customer Interactions</pluralLabel>
</CustomObject>
	',
	@body_format = 'HTML'

