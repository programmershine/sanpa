import React, { useEffect, useState } from 'react';

const LoadingScreen = () => {
    const [isLoading, setIsLoading] = useState(true);

    useEffect(() => {
        const timer = setTimeout(() => {
            setIsLoading(false);
        }, 4000); // 2초 후에 애니메이션을 시작하기 위해 2초를 더 지연시킵니다.

        return () => clearTimeout(timer);
    }, []);

    if (!isLoading) {
        return null;
    }

    return (
        <div className="loading-screen"
             style={{position: "absolute", width: "480px", height: "1030px", textAlign: "center"}}>
            <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
            <div>
                <p style={{fontSize: '24px', color: '#999', fontWeight: 'normal'}}>안심 출산 도우미</p>
            </div>
            <br/>
            <div>
                <img src="/img/sanpaIcon.png" alt="로딩 중"/>
            </div>
            <br/><br/><br/><br/>
            <div>
                <img src="/img/sanpaLogo.png" alt="로고"/>
            </div>
            <div>
                <span style={{fontSize: '36px', color: '#ff578b'}}><strong>산</strong>모's <strong>파</strong>트너</span>
            </div>
            <style jsx>{`
                .loading-screen {
                    background-color: rgba(255, 255, 255, 1);
                    width: 100%;
                    height: 100vh;
                    top: 0;
                    left: 0;
                    animation: fadeOut 2s forwards; /* fadeOut 애니메이션을 2초 동안 적용하고 마지막 스타일을 유지합니다. */
                    z-index: 999;
                    animation-delay: 2s; /* 애니메이션 시작을 2초 후로 지연시킵니다. */
                }

                @keyframes fadeOut {
                    from {
                        opacity: 1; /* 시작 값: 완전 불투명 */
                    }
                    to {
                        opacity: 0; /* 종료 값: 완전 투명 */
                    }
                }
            `}</style>
        </div>
    );
}

export default LoadingScreen;
