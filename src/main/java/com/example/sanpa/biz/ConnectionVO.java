package com.example.sanpa.biz;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@Alias("ConnectionVO")
public class ConnectionVO {

    public String helper_id;
    public String mother_id;
    public String nicknameOfHelper;
    public String relation;
    public String helper_name;
    public String helper_tel;
    public String mother_name;
    public int locationallowhtm;
    public int locationallowmth;

    public String tableName;


}