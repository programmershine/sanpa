// Header.js
import React from 'react';

const Header = () => {
    const handleLogoClick = () => {
        // 경로를 직접 지정하여 페이지 이동
        window.location.href = '/login_move';
    };

    return (
        <div style={{ zIndex: 251, position: 'absolute', top: 0, width: '480px', height: '100px', background: 'white', boxShadow: '0 0 4px 4px #ccc', fontSize: 0}}>
            {/* 메뉴 */}
            <div style={{display: 'flex', alignItems: 'center', width: '50px',height: '50px', position: 'absolute',top: '40px', left: '12px' }}>
                <i className="bi bi-list" style={{height:'64px', fontSize: '48px', color: 'gray' }}></i>
            </div>
            {/* 로고 */}
            <div style={{ display: 'flex', justifyContent: 'center', marginTop: '48px', cursor: 'pointer' }} onClick={handleLogoClick}>
                <img src="/img/header_sanpaLogo.png" alt="로고"/>
            </div>
            {/* 프로필 */}
            <div style={{ position: 'absolute', top: '30px', right: '20px', width: '60px', height: '60px', background: 'black', borderRadius: '30px' }}></div>
        </div>
    );
}

export default Header;
