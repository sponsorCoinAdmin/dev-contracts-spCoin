// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract StructSerialization
{
    event exactUserStructEvent(uint32 id, string name);

    //Use only fixed size simple (uint,int) types!
    struct ExactUserStruct
    {
        uint32 id;
        string name;
    }

    // ToDo
 /*
     function showStruct(ExactUserStruct memory u) private
    {
        exactUserStructEvent(u.id, u.name);
    }

    function exactUserStructToBytes(ExactUserStruct memory u) private
    returns (bytes memory data)
    {
        // _size = "sizeof" u.id + "sizeof" u.name
        uint _size = 4 + bytes(u.name).length;
        bytes memory _data = new bytes(_size);

        uint counter=0;
        for (uint i=0;i<4;i++)
        {
            _data[counter]=(u.id>>(8*i)&uint32(255));
            counter++;
        }

        for (uint i=0;i<bytes(u.name).length;i++)
        {
            _data[counter]=bytes(u.name)[i];
            counter++;
        }

        return (_data);
    }


    function exactUserStructFromBytes(bytes memory data) private
    returns (ExactUserStruct memory u)
    {
        for (uint i=0;i<4;i++)
        {
            uint32 temp = uint32(data[i]);
            temp<<=8*i;
            u.id^=temp;
        }

        bytes memory str = new bytes(data.length-4);

        for (uint i=0;i<data.length-4;i++)
        {
            str[i]=data[i+4];
        }

        u.name=string(str);
     }

    
    function test()
    {
        //Create and  show struct
        ExactUserStruct memory struct_1=ExactUserStruct(1234567,"abcdef");
        showStruct(struct_1);

        //Serializing struct
        bytes memory serialized_struct_1 = exactUserStructToBytes(struct_1);

        //Deserializing struct
        ExactUserStruct memory struct_2 = exactUserStructFromBytes(serialized_struct_1);

        //Show deserealized struct
        showStruct(struct_2);
    }
    */
}
