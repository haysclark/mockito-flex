package org.mockito.integrations.flexunit4
{
import flash.utils.getDefinitionByName;

import flex.lang.reflect.Field;
import flex.lang.reflect.Klass;

public class MockitoMetadataTools
{
    /**
     * Supported metadata
     * [Mock] attempts to assign mock object based on a field type assuming default constructor
     * Metadata parameters:
     * type="FQCN" mock object type (fully qualified class name)
     * argsList="fieldName" a name of field/property that holds array of arguments to pass to the mock constructor (if required)
     */
    private static const MOCK_METADATA:String = "Mock";
    private static const MOCK_METADATA_TYPE_KEY:String = "type";
    private static const MOCK_METADATA_ARGUMENTS_VAR:String = "argsList";
    private static const MOCK_METADATA_MOCK_NAME:String = "mockName";

    public static function hasMockClasses(testClass:Class):Boolean
    {
        var klass:Klass = new Klass(testClass);

        for each(var field:Field in klass.fields)
        {
            if (field.hasMetaData(MOCK_METADATA))
            {
                return true;
            }
        }

        return false;
    }

    public static function getMockInitializers(testClass:Class):Array
    {
        var mockInitializers:Array = [];
        var klass:Klass = new Klass(testClass);
        for each(var field:Field in klass.fields)
        {
            if (!field.hasMetaData(MOCK_METADATA))
                continue;
            var mockClass:Class;
            var mockClassName:String = field.getMetaData(MOCK_METADATA, MOCK_METADATA_TYPE_KEY);
            if (!mockClassName)
            {
                // mockClass = field.type;
                throw new Error("Please provide mock class name [Mock(type='class.to.mock.Name')]");
            }
            else
            {
                mockClass = mapClass(mockClassName);
            }
            var name:String = field.getMetaData(MOCK_METADATA, MOCK_METADATA_MOCK_NAME);
            var argumentsProperty:String = field.getMetaData(MOCK_METADATA, MOCK_METADATA_ARGUMENTS_VAR);
            mockInitializers.push({type: mockClass, argsProperty: argumentsProperty, fieldName: field.name, mockName: name});
        }
        return mockInitializers;
    }

    private static function mapClass(className:String):Class
    {
        var klass:Class = null;

        try
        {
            klass = getDefinitionByName(className) as Class;
        }
        catch(error:Error)
        {
            throw new MockitoMetadataError("[Mock] metadata specified invalid class: " + className);
        }

        return klass;
    }

    public static function getArgValuesFromMetaDataNode(nodes:XMLList, metaDataName:String, key:String):Array
    {
        var value:String;
        var metaNodes:XMLList;

        var values : Array = new Array();

        for each(var node : XML in nodes.(@name == metaDataName))
        {

            var typeArg : String = null;
            var defaultArg : String = null;

            if (node.arg)
            {
                typeArg = String(node.arg.(@key == key).@value);
                defaultArg = String(node.arg.(@key == "").@value);
            }

            var hasType : Boolean = (typeArg.length > 0);
            var hasDefault : Boolean = (defaultArg.length > 0);

            if (hasType)
            {
                if (values.indexOf(typeArg) == -1)
                {
                    values.push(typeArg);
                }
            }
            else if (hasDefault)
            {
                if (values.indexOf(defaultArg) == -1)
                {
                    values.push(defaultArg);
                }
            }
        }

        return values;
    }
}
}