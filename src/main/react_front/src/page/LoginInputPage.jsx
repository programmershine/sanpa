import React, { useState } from 'react';

const LoginInputPage = ({ handleLogin }) => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [loggedIn_User, setLoggedIn_User] = useState('');
    const [helper_Status, setHelper_Status] = useState(5);
    const [isFilled, setIsFilled] = useState(false);

    const handleSubmit = async (event) => {
        event.preventDefault();
        try {
            const response = await handleLogin(username, password);
            if (response && response.helper_id != null) {
                console.log("Logged in as:", response.helper_id);
                setLoggedIn_User(response.helper_id);
                setHelper_Status(response.helper_status);
                sessionStorage.setItem('loginData', response.helper_id);
                window.location.href = `/login_move`;
            } else {
                console.error('Login failed:', response);

            }
        } catch (error) {
            console.error('Login error:11111111111', error);
            alert("입력정보가 없습니다");
        }
    };

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        if (name === "helper_id") {
            setUsername(value);
        } else if (name === "helper_password") {
            setPassword(value);
        }
        setIsFilled(username !== '' && password !== '');
    };

    return (
        <div style={{ marginTop: '200px' }}>
            <img src="/img/sanpaLogo.png" alt="Logo" />
            <h1 style={{ color: 'rgba(0, 0, 0, 0.5)', margin: '40px auto' }}>로그인</h1>
            <form onSubmit={handleSubmit}>
                <input
                    type="text"
                    placeholder="아이디"
                    name="helper_id"
                    required
                    value={username}
                    onChange={handleInputChange}
                    style={{
                        background: '#fffcfc',
                        color: 'rgba(0, 0, 0, 0.5)',
                        padding: '10px',
                        margin: '10px',
                        fontSize: '20px',
                        fontWeight: 'bold',
                        borderRadius: '15px',
                        border: '1px solid rgba(0, 0, 0, 0.5)',
                    }}
                />
                <input
                    type="password"
                    placeholder="비밀번호"
                    name="helper_password"
                    required
                    value={password}
                    onChange={handleInputChange}
                    style={{
                        background: '#fffcfc',
                        color: 'rgba(0, 0, 0, 0.5)',
                        padding: '10px',
                        margin: '10px',
                        fontSize: '20px',
                        fontWeight: 'bold',
                        borderRadius: '15px',
                        border: '1px solid rgba(0, 0, 0, 0.5)',
                    }}
                />
                <p style={{ textAlign: 'left', marginLeft: '100px', fontWeight: 'bold', color: 'rgba(0, 0, 0, 0.4)', marginTop: '50px', marginBottom: '50px' }}>
                    <input type="checkbox" />&nbsp;로그인 유지
                </p>
                <button
                    type="submit"
                    className="btn2"
                    style={{
                        width: '287px',
                        height: '44px',
                        color: 'white',
                        background: isFilled ? '#FF69B4' : '#ccc',
                        textAlign: 'center',
                        fontSize: '25px',
                        padding: '25px auto',
                        borderRadius: '15px',
                        boxShadow: '2px 4px 4px 0px rgba(0,0,0,0.4)',
                        border: 'none',
                    }}
                >로 그 인</button>
            </form>
            <br />
            <div style={{ display: 'flex', justifyContent: 'center' }}>
                <button onClick={() => window.location.href='insertHelper'} className="btn2" style={{ fontWeight: 'bold', fontSize: '16px', color: 'rgba(0, 0, 0, 0.3)', margin: '40px 20px', background: 'white', border: 'none' }}>
                    회원가입
                </button>
                <button onClick={() => window.location.href='findId'} className="btn2" style={{ fontWeight: 'bold', fontSize: '16px', color: 'rgba(0, 0, 0, 0.3)', margin: '40px 20px', background: 'white', border: 'none' }}>
                    아이디 찾기
                </button>
                <button onClick={() => window.location.href='findPassword'} className="btn2" style={{ fontWeight: 'bold', fontSize: '16px', color: 'rgba(0, 0, 0, 0.3)', margin: '40px 20px', background: 'white', border: 'none' }}>
                    비밀번호 찾기
                </button>
            </div>
            <style type="text/css">
                {`
                input::placeholder {
                    color: rgba(0, 0, 0, 0.4);
                }
                .btn2:hover {
                    background: #FF7ac5 !important;
                    border-radius: 15px;
                }
                `}
            </style>
        </div>
    );
};

export default LoginInputPage;