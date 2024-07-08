import React from 'react';


const MothersNav = ({onPageChange,btnColor1,btnColor2,btnColor3}) => {


    return (
        <div style={{ width: '480px', textAlign: 'center', position: 'absolute', top: '100px'}}>
            <div style={{
                width: '420px',
                height: '60px',
                background: 'white',
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'center',
                fontSize: '20px',
                margin: '0 auto',
                color: '#999',
                fontWeight: 'bold'
            }}>
                <div onClick={() => window.location.href='sanmoz'} style={{color: btnColor1}}>
                    산모즈 List
                </div>
                <span style={{margin: '0 10px'}}>|</span>
                <div onClick={() => window.location.href='searchPage'} style={{color: btnColor2}}>
                    산모즈 추가
                </div>
                <span style={{margin: '0 10px'}}>|</span>
                <div onClick={() => onPageChange('location')} style={{color: btnColor3}}>
                    산모즈 위치
                </div>
            </div>
        </div>
    );
}

export default MothersNav;